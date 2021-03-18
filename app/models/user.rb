class User < ApplicationRecord
  has_many :authored_description_tracks, class_name: "DescriptionTrack", foreign_key: 'track_author_id'
  has_many :comments_on_tracks, class_name: 'DescriptionTrackComment', foreign_key: 'comment_author_id'
end
