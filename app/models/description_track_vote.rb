class DescriptionTrackVote < ApplicationRecord
  belongs_to :description_track, foreign_key: 'desc_track_id'
  belongs_to :voter, class_name: 'User'
  enum vote_dir: { up: "up", down: "down" }
end