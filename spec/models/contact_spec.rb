require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Contact do
  before(:each) do
    @valid_attributes = {
      :first_name => "Oliver",
      :last_name => "Nightingale",
      :email => "oliver@mail.com",
      :phone => "00 123 456789"
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
    it "should be invalid with a phone not in the format 00 XXX XXXXXX"
  end
end
