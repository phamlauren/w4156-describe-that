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
        password: 'drowssap',
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
    
    # Videos must exist for description track to exist
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

    # Description tracks must exist for description to exist
    desc_track_table = [
      {
        video_id: 1,
        track_author_id: 1,
        lang: 'en',
        is_generated: 1
      },
      {
        video_id: 2,
        track_author_id: 2,
        lang: 'en',
        is_generated: true
      },
    ]
    desc_track_table.each do |desc_track|
      DescriptionTrack.create! desc_track
    end

  end

  # For each seeded video, create a description track
  describe "video model" do
    # Seed videos: simulates retrieving them from YouTube API
    it "creates videos" do
      videos_table = [
        {
          yt_video_id: 500
        },
        {
          yt_video_id: 600
        },
        {
          yt_video_id: 700
        },
        {
          yt_video_id: 800
        },
      ]
      videos_table.each do |video|
        Video.create! video
      end
      expect(Video.exists?(:yt_video_id=>600)).to eq(true)
    end

    it "creates description tracks for videos" do
      desc_track_table = [
        {
          video_id: 3,
          track_author_id: 3,
          lang: 'en',
          is_generated: true
        },
        {
          video_id: 4,
          track_author_id: 1,
          lang: 'en',
          is_generated: true
        },
      ]
      desc_track_table.each do |desc_track|
        DescriptionTrack.create! desc_track
      end
      expect(DescriptionTrack.exists?(:video_id=>4, :track_author_id=>1)).to eq(true)
    end

    # For each description track, create a description
    it "creates descriptions for description tracks" do
      desc_table = [
        {
          desc_track_id: 1,
          start_time_sec: '00:00:10',
          pause_at_start_time: 'en',
          audio_file_loc: 'loc1',
          desc_text: 'Description text for desc_track_id 1',
        },
        {
          desc_track_id: 2,
          start_time_sec: '00:10:00',
          pause_at_start_time: 'en',
          audio_file_loc: 'loc2',
          desc_text: 'Description text for desc_track_id 2',
        },
      ]
      desc_table.each do |desc|
        Description.create! desc
      end
      expect(Description.exists?(:desc_track_id=>1, :audio_file_loc=>'loc1')).to eq(true)
    end

  end


  # For a video, get_all_desc_tracks /// MODEL METHOD
  describe "gets all description tracks for videos" do
    
  end

  # For a video, get_all_desc_track_with_lang /// MODEL METHOD
  describe "gets all description tracks with their language for videos" do
    
  end

  # For a video, video_exists /// MODEL METHOD
  describe "checks if video exists" do
    
  end

end
