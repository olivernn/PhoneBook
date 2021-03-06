require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Contact do
  before(:each) do
    @valid_attributes = {
      :first_name => "Oliver",
      :last_name => "Nightingale",
      :email => "oliver@mail.com",
      :phone => "00 123 456789",
      :twitter_user_name => "minimalpixel"
    }
    
    @contact = Contact.new
  end

  it "should create a new instance given valid attributes" do
    Contact.create!(@valid_attributes)
  end
  
  it "should be invalid without a first name" do
    @contact.attributes = @valid_attributes.except(:first_name)
    @contact.should_not be_valid
  end
  
  it "should be invalid without a last name" do
    @contact.attributes = @valid_attributes.except(:last_name)
    @contact.should_not be_valid
  end
  
  describe "validity of email" do
    # this is far from an exhaustive list of invalid email addresses.
    it "should be invalid with an invalidly-formatted email address" do
      @contact.attributes = @valid_attributes.except(:email)
      ["oliver", "oliver@mail", "olivermail.com", "@com"].each do |invalid_email|
        @contact.email = invalid_email
        @contact.should_not be_valid
      end
    end
  
    it "should be invalid with a duplicate email address" do
      Contact.create!(@valid_attributes)
      @contact.attributes = @valid_attributes
      @contact.should_not be_valid
    end
  
    it "should be valid without an email address" do
      @contact.attributes = @valid_attributes.except(:email)
      @contact.should be_valid
    end
  end
  
  describe "validity of the phone" do
    it "should be invalid with a phone not in the format 00 XXX XXXXXX" do
      @contact.attributes = @valid_attributes.except(:phone)
      ["123", "1234567890", "00123123456", "not a phone number", "00 123 1234567", "00 1234 12345"].each do |invalid_phone|
        @contact.phone = invalid_phone
        @contact.should_not be_valid
      end
    end
    
    it "should be valid without a phone" do
      @contact.attributes = @valid_attributes.except(:phone)
      @contact.should be_valid
    end
  end
  
  it "should have a full name" do
    @contact.attributes = @valid_attributes
    @contact.full_name.should == @contact.first_name + " " + @contact.last_name
  end
  
  it "should allow picture upload" do
    @contact.attributes = @valid_attributes
    @contact.picture = File.new(RAILS_ROOT + '/spec/fixtures/giraffe.jpg')
    @contact.save
  end
  
  it "should be invalid with a picture larger than 1MB" do
    @contact.attributes = @valid_attributes
    @contact.picture = File.new(RAILS_ROOT + '/spec/fixtures/too_big.jpg')
    @contact.should_not be_valid
  end
  
  # this is not an extensive list of invalid formats
  it "should be invalid with a picture that isn't a jpeg" do
    @contact.attributes = @valid_attributes
    @contact.picture = File.new(RAILS_ROOT + '/spec/fixtures/wrong_format.gif')
    @contact.should_not be_valid
  end
  
  it "should have a human friendly url including the full name" do
    @contact.attributes = @valid_attributes
    @contact.save
    @contact.to_param.should == "#{@contact.id}-#{@contact.full_name.parameterize.to_s}"
  end
  
  it "should have many tweets" do
    association = Contact.reflect_on_association(:tweets)
    association.should_not be_nil
    association.macro.should == :has_many
  end
  
  it "should give a twitter search query" do
    @contact.attributes = @valid_attributes
    @contact.send(:twitter_search_query).should == "from:" + @contact.twitter_user_name
  end
  
  it "should know if it is a twitterer" do
    @contact.attributes = @valid_attributes.except(:twitter_user_name)
    @contact.twitterer?.should == false
    @contact.twitter_user_name = @valid_attributes[:twitter_user_name]
    @contact.twitterer?.should == true
    @contact.twitter_user_name = " "
    # need to validate first
    @contact.valid?
    @contact.twitterer?.should == false
  end
  
  it "should have a tweeple named scope that returns all twitterers" do
    Contact.tweeple.proxy_options.should == {:conditions => "twitter_user_name IS NOT NULL"}
  end
end
