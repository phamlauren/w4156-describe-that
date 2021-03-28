class DescriptionTrack < ApplicationRecord
  belongs_to :video
  belongs_to :author, class_name: "User", foreign_key: "track_author_id"#  optional: true # optional: true is temporary for cucumber
                                                                                          # remove for deploy and prod
  has_many :descriptions, class_name: "Description", foreign_key: 'desc_track_id'
  has_many :votes, class_name: 'DescriptionTrackVote', foreign_key: "desc_track_id"
  has_many :comments, class_name: 'DescriptionTrackComment', foreign_key: "desc_track_id"

  def get_all_descriptions
    Description.where(desc_track_id: id).order('start_time_sec ASC').to_a
  end

  def get_all_comments
    DescriptionTrackComment.where(desc_track_id: id)
  end

  # used by iter-1: generates all descriptions for a list of times and texts
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
