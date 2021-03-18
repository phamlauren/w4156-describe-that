class User < ApplicationRecord
  has_many :authored_descriptions, class_name: "DescriptionTrack", foreign_key: 'track_author_id', optional: true
  has_many :comments_on_tracks, class_name: 'DescriptionTrackComment', foreign_key: 'comment_author_id', optional: true
end
