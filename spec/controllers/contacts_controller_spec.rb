require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContactsController do
  def mock_contact(stubs={})
    @mock_contact ||= mock_model(Contact, stubs)
  end
  
  describe "responding to a GET index" do
    describe "without search parameters" do
      it "should paginate all contacts as @contacts, 10 per page" do
        Contact.should_receive(:search).with(:first_name => nil, :last_name => nil, :page => nil).and_return([mock_contact])
        get :index, :page => nil, :first_name => nil, :last_name => nil
        assigns[:contacts].should == [mock_contact]
      end
    end
    
    describe "with search parameters" do
      it "should paginate all contacts as @contacts that match the search criteria, 10 per page" do
        Contact.should_receive(:search).with(:first_name => "Oliver", :last_name => "Nightingale", :page => nil).and_return([mock_contact])
        get :index, :page => nil, :first_name => "Oliver", :last_name => "Nightingale"
        assigns[:contacts].should == [mock_contact]
      end
    end
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
      Contact.should_receive(:new).and_return(mock_contact)
      get :new
      assigns[:contact].should == mock_contact
    end
  end
  
  describe "responding to a GET edit" do
    it "should expose a single contact as @contact" do
      Contact.should_receive(:find).with("1").and_return(mock_contact)
      get :edit, :id => "1"
      assigns[:contact].should == mock_contact
    end
  end
  
  describe "responding to a PUT update" do
    describe "with valid parameters" do
      it "should update an existing contact" do
        Contact.should_receive(:find).with("1").and_return(mock_contact)
        mock_contact.should_receive(:update_attributes).with({'these' => 'params'}).and_return(true)
        put :update, :id => "1", :contact => {'these' => 'params'}
        assigns[:contact].should == mock_contact
        flash[:notice].should == "Successfully updated contact."
      end
      
      it "should redirect to the contact show page" do
        Contact.stub!(:find).and_return(mock_contact(:update_attributes => true))
        put :update, :id => "1", :contact => {'these' => 'params'}
        response.should redirect_to(contact_path(mock_contact))
      end
    end
    
    describe "with invalid parameters" do
      it "should not update an existing contact" do
        Contact.should_receive(:find).with("1").and_return(mock_contact)
        mock_contact.should_receive(:update_attributes).with({'these' => 'params'}).and_return(false)
        put :update, :id => "1", :contact => {'these' => 'params'}
        assigns[:contact].should == mock_contact
      end
      
      it "should re-redner the form" do
        Contact.stub!(:find).and_return(mock_contact(:update_attributes => false))
        put :update, :id => "1", :contact => {'these' => 'params'}
        response.should render_template('edit')
      end
    end
  end
end
