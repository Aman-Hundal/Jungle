class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id #this assignes the user.id to a browser cookie session. Keeps the user logged in to navigate the webpage
      redirect_to products_path
    else
      render :new
    end
  end

end

#to sanitize our params (the input from the form on new.html.erb). Requirement for Rails 4
private
def user_params
  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
end

  
