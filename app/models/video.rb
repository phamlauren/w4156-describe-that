class Video < ApplicationRecord
  has_many :description_tracks

  def has_published_desc_track
    DescriptionTrack.exists?(video_id: id, published: true)
  end

  def get_all_desc_tracks
    DescriptionTrack.where(video_id: id).to_a
  end

  def get_all_desc_tracks_with_lang(lang_code)
    DescriptionTrack.where(video_id: id, lang: lang_code).to_a
  end

  def video_exists
    deleted if deleted
    # TODO: Else call the YouTube API (or look at the video page) to check.
  end

  # get useful info for video, if return {} then the yt_video_id is invalid
  def video_info
    raise "no env key for YouTube!" if ENV["YT_API_KEY"]==nil
    response = HTTP.get("https://youtube.googleapis.com/youtube/v3/videos", :params => {:part => "snippet", :id => yt_video_id, :key => ENV["YT_API_KEY"]})
    result = JSON.parse(response)
    return result["items"].length()==1 ? result["items"][0]["snippet"] : {}
  end
end
