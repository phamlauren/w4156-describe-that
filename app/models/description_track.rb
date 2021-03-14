class DescriptionTrack < ApplicationRecord
  belongs_to :video
  belongs_to :user
  has_many :descriptions

  def get_all_descriptions
    if is_generated # if generated descriptions...
      Description
        .joins("INNER JOIN generated_descriptions ON generated_descriptions.description_id = descriptions.id")
        .order('start_time_sec ASC')
        .to_a
    else # if recorded descriptions...
      Description
        .joins("INNER JOIN recorded_descriptions ON recorded_descriptions.description_id = descriptions.id")
        .order('start_time_sec ASC')
        .to_a
    end
  end
end
