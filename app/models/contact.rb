class Contact < ActiveRecord::Base
  include ValidationRegExp
  include TwitterSearchClient
  
  default_scope :order => 'last_name ASC, first_name ASC'
  
  named_scope :tweeple, :conditions => "twitter_user_name IS NOT NULL"
  
  has_attached_file :picture,
    :styles => {
      :thumbnail => "50x50#",
      :normal => "200x200>"
    }
    
  has_many :tweets
  
  before_validation :strip_twitter_user_name
  
  validates_presence_of :first_name, :last_name
  validates_format_of :email, :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD, :allow_nil => true, :allow_blank => true
  validates_uniqueness_of :email, :allow_nil => true, :allow_blank => true
  validates_format_of :phone, :with => RE_PHONE_OK, :message => MSG_PHONE_BAD, :allow_nil => true, :allow_blank => true
  validates_attachment_size :picture, :less_than => 1.megabytes, :message => "must be less than 1MB"
  validates_attachment_content_type :picture, :content_type => 'image/jpeg'
  
  def to_param
    "#{id}-#{full_name.parameterize.to_s}"
  end
  
  def full_name
    first_name + " " + last_name
  end
  
  def self.search(options={})
    {:first_name => "", :last_name => ""}.merge(options)
    self.paginate(:per_page => 10,
                  :page => options[:page],
                  :conditions => ["first_name LIKE ? AND last_name LIKE ?", "%#{options[:first_name]}%", "%#{options[:last_name]}%"])
  end
  
  def twitterer?
    !twitter_user_name.nil? && !twitter_user_name.empty?
  end
  
  def refresh_tweets
    if twitterer?
      results = twitter_search.query :q => twitter_search_query, :rpp => '30'
      self.tweets.add_new_tweets(results) if results
    end
  end
  
  private
  
  def twitter_search_query
    "from:" + twitter_user_name
  end
  
  def strip_twitter_user_name
    twitter_user_name.strip!
  end
end
