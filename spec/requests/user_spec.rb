require 'rails_helper'

RSpec.describe "Users", type: :request do
  before (:all) do
    # These are seeded by the Cucumber tests
    # users_table = [
    #   {
    #     email: 'vishnu.nair@columbia.edu',
    #     password: 'password'
    #   },
    #   {
    #     email: 'xw2765@columbia.edu',
    #     password: 'drowssap'
    #   },
    #   {
    #     email: 'lyp2106@barnard.edu',
    #     password: 'password'
    #   },
    # ]
  end

  describe "GET /user" do
    it "makes it to the index page" do
      get '/user'
      expect(response).to render_template('index')
    end
  end
  describe "GET /user/new" do
    it "makes it to the new page" do
      get '/user/new'
      expect(response).to render_template('new')
    end
  end
  describe "POST /user" do
    it "creates a user" do
      post '/user', params: { user: { email: 'alias@columbia.edu', password: 'possward' } }
      expect(User.exists?(:email=>'alias@columbia.edu')).to eq(true)
    end
  end
  describe "GET /user/login" do
    it "makes it to the login page" do
      get '/user/login'
      expect(response).to render_template('login')
    end
  end
  describe "POST /user/login" do
    it "successfully logs in with email and password" do
      post '/user/login', params: { user: { email: 'lyp2106@barnard.edu', password: 'password' }}
      expect(response).to redirect_to('/user')
    end
    it "fails to log in with an incorrect password" do
        post '/user/login', params: { user: { email: 'lyp2106@barnard.edu', password: 'possward' }}
        expect(assigns(:err)).to eq('You have entered an incorrect password for this email.')
    end
    it "fails to log in with an email that does not exist yet" do
        post '/user/login', params: { user: { email: 'lyp2106@columbia.edu', password: 'password' }}
        expect(assigns(:err)).to eq('A user does not yet exist for this email.')
      
    end
  end
end
