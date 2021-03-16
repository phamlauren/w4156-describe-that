require 'rails_helper'

RSpec.describe "Videos", type: :request do
  before (:all) do
    # Seed some videos to test on
    videos_table = [
      {
        yt_video_id: 'WrdsotPDrRg' # Darwin Derby by Vulfpeck
      },
      {
        yt_video_id: 'Cj-AL-J98U0' # Merry-Go-Round by Joe Hisaishi
      },
      {
        yt_video_id: 'Qn5IpWXWub0' # Pretty Boy by Joji feat. Lil Yachty
      },
      {
        yt_video_id: 'TvpJWAx_NkY' # Portrait of a Time by Pete Cat Recording Co.
      },
    ]
    videos_table.each do |video|
      Video.create! video
    end
  end
  describe "GET /" do
    it "renders index template" do
      get '/'
      expect(response).to render_template('index')
    end
  end
  describe "GET /video" do
    it "retrieves from the YouTube API" do
      get '/video', params: { yt_url: 'https://www.youtube.com/watch?v=WrdsotPDrRg' }
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /video/:id" do
    it "gets the show page for a video" do
      get '/video/9'
      expect(assigns(:video).yt_video_id).to eq("WrdsotPDrRg")
    end
    it "gets the err message for a video that does not exist" do
      get '/video/100'
      expect(assigns(:err)).to eq("Sorry, we couldn't find a video with that YouTube link.")
    end
  end
  describe "GET /video/:id/describe" do
    it "gets the video desciption page" do
      get '/video/9/describe'
    end
  end
  describe "POST /video/:id/describe" do
    it "creates a description for an existing video" do
      post '/video/9/describe', params: { id: 0, time: '00:00:00', description: 'of all the creatures in the sea my favorite is the bass' }
      expect(DescriptionTrack.exists?(:video_id=>9)).to eq(true)
    end
  end
  describe "POST /video/:id/request" do
    it "makes a request to the video that does not have any descriptions" do
      post '/video/9/request'
      expect(flash[:notice]).to eq("This feature is not implemented yet. But if it was, you would have been notified: 'You have successfully requested AD for this video.'")
    end
  end
  describe "GET /user" do
    it "makes it to the index page" do
      get '/user'
      expect(response).to render_template('index')
    end
  end
  describe "GET /user/new" do
    pending "add some examples (or delete) #{__FILE__}"
  end
  describe "POST /user" do
    it "creates a user" do
      post '/user', params: { user: { email: 'alias@columbia.edu', password: 'possward' } }
      expect(User.exists?(:email=>'alias@columbia.edu')).to eq(true)
    end
  end
  describe "GET /user/login" do
    pending "add some examples (or delete) #{__FILE__}"
  end
  describe "POST /user/login" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end
