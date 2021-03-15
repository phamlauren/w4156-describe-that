require 'rails_helper'

RSpec.describe Video, type: :model do

  before (:all) do
    # Seed videos: simulates retrieving them from YouTube API
    videos_table = [
      {
        id: 1,
        yt_video_id: 1
      },
      {
        id: 2,
        yt_video_id: 2
      },
      {
        id: 3,
        yt_video_id: 3
      },
      {
        id: 4,
        yt_video_id: 4
      },
    ]
    videos_table.each do |video|
      Video.create video
    end
  end

  # For each seeded video, create a description track
  describe "create description tracks for videos" do
    
  end

  # For each description track, create a description
  describe "create descriptions for description tracks" do
    
  end

  # For a video, get_all_desc_tracks
  describe "get all description tracks for videos" do
    
  end

  # For a video, get_all_desc_track_with_lang
  describe "get all description tracks with their language for videos" do
    
  end

  # For a video, video_exists
  describe "check if video exists" do
    
  end

  # For a description track, get_all_descriptions
  describe "get all descriptions for description tracks" do
    
  end

  # For a description, assert generate_unique_name works
  describe "check generation of description track audio file names" do
    
  end

end
