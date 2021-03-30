require 'rails_helper'

RSpec.describe "Demonstration Paths", type: :request do
  before (:all) do
  end

  describe "GET /user" do
    it "renders index template" do
      get '/user'
      expect(response).to render_template('index')
    end
  end

  describe "GET /video/undescribed" do
    it "renders undescribed videos" do
      get '/video/undescribed/'
      expect(response).to render_template('index_undescribed')
    end
  end
  
  describe "Get /dashboard" do
    it "renders user's dashboard" do
      get '/dashboard'
      expect(assigns(:user).auth0_id).to eq('fdsaasdf')
    end
  end
end
