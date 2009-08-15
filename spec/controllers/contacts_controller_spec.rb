require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContactsController do
  def mock_contact(stubs={})
    @mock_contact ||= mock_model(Contact, stubs)
  end
  
  describe "responding to a GET new" do
    it "should expose a new contact as @contact" do
      Contact.should_receive(:new).and_return(mock_contact)
      get :new
      assigns[:contact].should == mock_contact
    end
  end
  
  describe "responding to a POST create" do
    describe "with valid parameters" do
      it "should create a new contact" do
        Contact.should_receive(:new).with({'these' => 'params'}).and_return(mock_contact)
        mock_contact.should_receive(:save).and_return(true)
        post :create, :contact => {'these' => 'params'}
        assigns[:contact].should == mock_contact
        flash[:notice].should == "Successfully created contact."
      end
      
      it "should redirect to the contact show page" do
        Contact.stub!(:new).and_return(mock_contact(:save => true))
        post :create, :article => {}
        response.should redirect_to(contact_path(mock_contact))
      end
    end
    
    describe "with invalid parameters" do
      it "should expose the unsaved contact as @contact" do
        Contact.should_receive(:new).with({'these' => 'params'}).and_return(mock_contact)
        mock_contact.should_receive(:save).and_return(false)
        post :create, :contact => {'these' => 'params'}
        assigns[:contact].should == mock_contact
        flash[:notice].should == nil
      end
      
      it "should re-render the form" do
        Contact.stub!(:new).and_return(mock_contact(:save => false))
        post :create, :contact => {}
        response.should render_template('new')
      end
    end
  end
  
  describe "responding to a GET new" do
    it "should expose a single contact as @contact" do
      Contact.should_receive(:find).with("1").and_return(mock_contact)
      get :show, :id => "1"
      assigns[:contact].should == mock_contact
    end
  end
end
