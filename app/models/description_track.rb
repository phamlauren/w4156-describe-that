class DescriptionTrack < ApplicationRecord
  belongs_to :video
  belongs_to :user, # optional: true # optional: true is temporary for cucumber
                                   # remove for deploy and prod
  has_many :descriptions

  def get_all_descriptions
    if is_generated
      Description.where(desc_track_id: id, desc_type: Description.desc_types[:generated]).order('start_time_sec ASC').to_a
    else
      Description.where(desc_track_id: id, desc_type: Description.desc_types[:recorded]).order('start_time_sec ASC').to_a
    end
  end
end
