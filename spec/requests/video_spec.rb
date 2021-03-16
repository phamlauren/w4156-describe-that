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
    pending "add some examples (or delete) #{__FILE__}"
  end
  describe "POST /video/:id/describe" do
    pending "add some examples (or delete) #{__FILE__}"
  end
  describe "POST /video/:id/request" do
    pending "add some examples (or delete) #{__FILE__}"
  end
  describe "GET /user" do
    pending "add some examples (or delete) #{__FILE__}"
  end
  describe "GET /user/new" do
    pending "add some examples (or delete) #{__FILE__}"
  end
  describe "POST /user" do
    pending "add some examples (or delete) #{__FILE__}"
  end
  describe "GET /user/login" do
    pending "add some examples (or delete) #{__FILE__}"
  end
  describe "POST /user/login" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end
