class DescriptionTrack < ApplicationRecord
  belongs_to :video
  belongs_to :user#, optional: true # optional: true is temporary for cucumber
                                   # remove for deploy and prod
  has_many :descriptions

  def get_all_descriptions
    if is_generated
      Description.where(desc_track_id: id, desc_type: Description.desc_types[:generated]).order('start_time_sec ASC').to_a
    else
      Description.where(desc_track_id: id, desc_type: Description.desc_types[:recorded]).order('start_time_sec ASC').to_a
    end
  end


  def generate_descriptions times, descriptions
    times = times.split("\n")
    descriptions = descriptions.split("\n")
    step = 0
    voice = Voice.create(common_name: "x", system_name: "a", provider: "x")
    until step >= times.length() do
      # hard code other parameters
      Description.create!(desc_track_id: id, start_time_sec: times[step], pause_at_start_time: false, desc_type: 'generated', audio_file_loc: "", desc_text: descriptions[step], voice_id: voice.id, voice_speed: 1.1)
      step += 1
    end
  end
end
