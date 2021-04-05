class UserController < ApplicationController

  def index
    @users = User.all
  end

  def dashboard
    # Test with background seeded user having sub = auth0_id = abcde
    session[:userinfo] = {"sub"=>"fdsaasdf"} if Rails.env.test?
    @user = User.find_by(auth0_id: session[:userinfo]['sub'])
  end
  
end
