require "rails_helper"

RSpec.describe DescriptionController, type: :controller do

  before (:all) do
    @author = User.find_or_create_by!(auth0_id: "fdsaasdf")
    @voice = Voice.find_or_create_by!(common_name: "Voice US A", system_name: "en-US-Wavenet-A", provider: "google_tts")
    @video = Video.find_or_create_by!(yt_video_id: "S1x76DoACB8") # "Frozen" teaser trailer
    @track = DescriptionTrack.find_or_create_by!(video_id: @video.id, track_author_id: @author.id, published: true, lang: "en")
    puts @track.id
  end

  describe "POST /description/new_generated" do
    it "should create a new generated description" do
      post "new_generated", params: { :pause_at_start_time => "1", :description => "test description", :voice_id => @voice.id, :voice_speed => 1.2, :track_id => @track.id, :time => 16.5 }, xhr: true
      expect(response).to have_http_status(200)
    end
  end

end
