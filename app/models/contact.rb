class Contact < ActiveRecord::Base
  include ValidationRegExp
  
  has_attached_file :picture,
    :styles => {
      :thumbnail => "100x100#",
      :normail => "300x300>"
    }
  
  validates_presence_of :first_name, :last_name
  validates_format_of :email, :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD, :allow_nil => true
  validates_uniqueness_of :email, :allow_nil => true
  validates_format_of :phone, :with => RE_PHONE_OK, :message => MSG_PHONE_BAD, :allow_nil => true
  validates_attachment_size :picture, :less_than => 1.megabytes, :message => "must be less than 1MB"
  validates_attachment_content_type :picture, :content_type => 'image/jpeg'
  
  def full_name
    first_name + " " + last_name
  end
end
