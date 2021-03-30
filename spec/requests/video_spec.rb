require 'rails_helper'

RSpec.describe "Videos", type: :request do
  before (:all) do
    # These videos are seeded by /models/video_spec.rb
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

    # Seed some video requests to test on
    video_request_table = [
      {
        video_id: 1,
        requested_lang: 'en',
        requester_id: 1
      },
      {
        video_id: 2,
        requested_lang: 'fr',
        requester_id: 2
      },
    ]
    video_request_table.each do |video_request|
      VideoRequest.create! video_request
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
      get '/video/4'
      expect(assigns(:video).yt_video_id).to eq("Qn5IpWXWub0")
    end
    it "gets the err message for a video that does not exist" do
      get '/video/100'
      expect(assigns(:err)).to eq("Sorry, we couldn't find a video with that YouTube link.")
    end
  end
  describe "GET /video/:id/describe" do
    it "gets the video desciption page" do
      get '/video/4/describe', params: { id: 4, lang: 'en' }
    end
  end
  describe "POST /video/:id/describe" do
    it "creates a description for an existing video" do
      post '/video/4/describe', params: { id: 4, lang: 'en' }
      expect(DescriptionTrack.exists?(:video_id=>4)).to eq(true)
    end
  end
  describe "POST /video/:id/request" do
    it "makes a request to the video that does not have any descriptions" do
      post '/video/4/request'
      expect(flash[:notice]).to eq("Your request has been saved!")
    end
  end
  describe "POST /video/:id/request" do
    it "makes a request that already has a request, which becomes an upvote" do
      post '/video/1/request', params: { id: 1, lang: 'en' }
      expect(flash[:notice]).to eq("Your request has been saved!")
    end
  end
  describe "GET /video_requests" do
    it "list all video requests" do
      get '/video_requests'
      expect(assigns(:requests_info).size).to eq(2)
    end
  end
  describe "POST /video_requests/:id" do
    it "makes an upvote request" do
      get '/video_requests/2'
      expect(flash[:notice]).to eq("Your request has been saved!")
    end
  end
  describe "POST /video_requests/:id" do
    it "prevents a user from upvoting more than once" do
      get '/video_requests/1'
      expect(flash[:notice]).to eq("You have already requested this video.")
    end
  end
  describe "POST /description_track/:id/switch_published" do
    it "publishes or unpublishes a description track" do
      post '/description_track/1/switch_published'
      expect(DescriptionTrack.find(1).published).to eq(false)
    end
  end

end
