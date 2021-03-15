require 'rails_helper'

RSpec.describe Video, type: :model do
  before (:all) do
    # User must exist for description track to exist
    users_table = [
      {
        email: 'vishnu.nair@columbia.edu',
        password: 'password',
        options: '{"default_lang": "en"}',
      },
      {
        email: 'xw2765@columbia.edu',
        password: 'password',
        options: '{"default_lang": "en"}',
      },
      {
        email: 'lyp2106@barnard.edu',
        password: 'password',
        options: '{"default_lang": "en"}',
      },
    ]
    users_table.each do |user|
      User.create! user
    end
    expect(User.exists?(:email=>'lyp2106@barnard.edu')).to eq(true)
  end

  # For each seeded video, create a description track
  describe "model" do
    # Seed videos: simulates retrieving them from YouTube API
    it "successfully creates videos" do
      videos_table = [
        {
          yt_video_id: 100
        },
        {
          yt_video_id: 200
        },
        {
          yt_video_id: 300
        },
        {
          yt_video_id: 400
        },
      ]
      videos_table.each do |video|
        Video.create! video
      end
      expect(Video.exists?(:yt_video_id=>200)).to eq(true)
    end

    it "successfully creates description tracks for videos" do
      desc_track_table = [
        {
          video_id: 100,
          track_author_id: 1,
          lang: 'en',
          is_generated: 1
        },
        {
          video_id: 200,
          track_author_id: 2,
          lang: 'en',
          is_generated: true
        },
        {
          video_id: 300,
          track_author_id: 3,
          lang: 'en',
          is_generated: true
        },
        {
          video_id: 400,
          track_author_id: 1,
          lang: 'en',
          is_generated: true
        },
      ]
      desc_track_table.each do |desc_track|
        DescriptionTrack.create! desc_track
      end
      expect(DescriptionTrack.exists?(:video_id=>100, :track_author_id=>1)).to eq(true)
    end

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
