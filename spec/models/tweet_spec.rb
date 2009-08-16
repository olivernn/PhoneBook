require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tweet do
  before(:each) do
    @valid_attributes = {
      :contact_id => 1,
      :text => "this is a tweet",
      :guid => 1,
      :tweeted_at => Time.now
    }
    @tweet = Tweet.new
  end

  it "should create a new instance given valid attributes" do
    Tweet.create!(@valid_attributes)
  end
  
  it "should belong to a contact" do
    association = Tweet.reflect_on_association(:contact)
    association.should_not be_nil
    association.macro.should == :belongs_to
  end
  
  it "should be invalid without some text" do
    @tweet.attributes = @valid_attributes.except(:text)
    @tweet.should_not be_valid
  end
  
  it "should be invalid without a tweeted_at" do
    @tweet.attributes = @valid_attributes.except(:tweeted_at)
    @tweet.should_not be_valid
  end
  
  it "should be invalid without a guid" do
    @tweet.attributes = @valid_attributes.except(:guid)
    @tweet.should_not be_valid
  end
  
  it "should have a recent named_scope which brings back the 5 most recent tweets" do
    Tweet.recent.proxy_options.should == {:order => "tweeted_at DESC", :limit => 5}
  end
end
