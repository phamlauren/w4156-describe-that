class Video < ApplicationRecord
  has_many :description_tracks

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
end
