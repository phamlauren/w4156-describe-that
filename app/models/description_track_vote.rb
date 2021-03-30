# :nocov:
class DescriptionTrackVote < ApplicationRecord
  belongs_to :description_track
  belongs_to :voter, class_name: 'User'
  enum vote_dir: { up: "up", down: "down" }
end
# :nocov: