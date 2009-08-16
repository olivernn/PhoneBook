class Tweet < ActiveRecord::Base
  belongs_to :contact
  
  validates_presence_of :text, :tweeted_at, :guid
  
  named_scope :recent, :order => "tweeted_at DESC", :limit => 5
  
  def self.add_new_tweets(results)
    results.each do |result|
      unless exists? :guid => result.id
        create!(:text => result.text, :tweeted_at => result.created_at, :guid => result.id)
      end
    end
  end
end
