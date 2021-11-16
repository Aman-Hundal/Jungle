class SessionController < ApplicationController
  def new
  end

  def create
    # @user = User.find_by_email(params[:email])
    # if @user && @user.authenticate(params[:password]) #verifies that user exists and password is correct/authenticated
    if @user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = @user.id #save the user.id to the browser cookie. Keeps the user logged in and able to go around website
      redirect_to products_path
    else #if login does not correct and email or password is incorrect HOW TO ADD ERROR MESSAGE?
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil #removes the browser cookie ending the logged in users session. no cookie anymore and user is logged out
    redirect_to '/login'
  end
end

#This is where we create (aka login) and destroy (aka logout) sessions.