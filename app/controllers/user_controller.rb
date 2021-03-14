class UserController < ApplicationController
  # Using default actions: new

  def index
    @users = User.all
  end

  def create
    @user = User.create!(user_params)
    flash[:notice] = "A user for #{@user.email} was successfully created."
    redirect_to user_path
  end
  
  def login_page
    render "login"
  end

  def login
    @user = User.find_by :email => user_params['email']
    if @user.nil?
      @err = "A user does not yet exist for this email."
      render "err"
    elsif user_params['password'] == @user.password
      redirect_to user_path
    else 
      @err = "You have entered an incorrect password for this email."
      render "err"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email,:password)
  end
end
