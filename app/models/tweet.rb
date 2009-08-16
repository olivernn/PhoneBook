class Tweet < ActiveRecord::Base
  belongs_to :contact
  
  validates_presence_of :text, :tweeted_at, :guid
  
  named_scope :recent, :order => "tweeted_at DESC", :limit => 5
end
