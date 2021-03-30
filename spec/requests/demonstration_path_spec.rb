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
  
  describe "Get /dashboard" do
    it "renders user's dashboard" do
      get '/dashboard'
      expect(assigns(:user).username).to eq('xw2765')
    end
  end
end
