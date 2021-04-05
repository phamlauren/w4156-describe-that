class User < ApplicationRecord
  has_many :authored_description_tracks, class_name: "DescriptionTrack", foreign_key: 'track_author_id'
  has_many :comments_on_tracks, class_name: 'DescriptionTrackComment', foreign_key: 'comment_author_id'
  has_many :video_requests, class_name: 'VideoRequest', foreign_key: 'requester_id'
  has_many :video_request_upvotes, class_name: 'VideoRequestUpvote', foreign_key: 'upvoter_id'
  has_many :votes_on_tracks, class_name: 'DescriptionTrackVote', foreign_key: 'voter_id'
  has_many :video_favorites, class_name: "VideoFavorite", foreign_key: 'user_id'
end
