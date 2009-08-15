class ContactsController < ApplicationController
  
  def index
    
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
end
