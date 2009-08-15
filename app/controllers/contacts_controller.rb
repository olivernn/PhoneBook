class ContactsController < ApplicationController
  
  def index
    @contacts = Contact.paginate(:per_page => 10, :page => params[:page])
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
