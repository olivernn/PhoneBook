class ContactsController < ApplicationController
  
  def index
    @contacts = Contact.search(:first_name => params[:first_name],
                               :last_name => params[:last_name],
                               :page => params[:page])
                               
    respond_to do |format|
      format.html # index.html.erb
      format.js   # index.js.erb
    end
  end
  
  def show
    @contact = Contact.find(params[:id])
  end
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      flash[:notice] = "Successfully created contact."
      redirect_to contact_path(@contact)
    else
      render 'new'
    end
  end
  
  def edit
    @contact = Contact.find(params[:id])
  end
  
  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:notice] = "Successfully updated contact."
      redirect_to contact_path(@contact)
    else
      render 'edit'
    end
  end
end
