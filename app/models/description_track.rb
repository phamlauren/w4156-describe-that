class DescriptionTrack < ApplicationRecord
  belongs_to :video
  belongs_to :user
  has_many :descriptions

  def get_all_descriptions
    Description.where(desc_track_id: id).order('start_time_sec ASC').to_a
  end
end
