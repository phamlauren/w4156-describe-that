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

  private
  def user_params
    params.require(:user).permit(:email,:password)
  end
end
