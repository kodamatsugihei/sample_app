class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end

  def create
  	@contact = Contact.new(contact_params)
  	if contact.save
  	  sign_in @user
  	  flash[:success] = "Send your inquiry has been completed"
  	  redirect_to @contact
  	else
  		redirect_to 'new'
  	end
  end

  private

  def contact_params
  	params.require(:contact).permit(:name, :email, :content)
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
  end

end
