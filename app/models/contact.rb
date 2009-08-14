class Contact < ActiveRecord::Base
  include ValidationRegExp
  
  validates_presence_of :first_name, :last_name
  validates_format_of :email, :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD, :allow_nil => true
  validates_uniqueness_of :email, :allow_nil => true
end
