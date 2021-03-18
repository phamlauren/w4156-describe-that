class VideoRequest < ApplicationRecord
  belongs_to :video
  belongs_to :requester, class_name: 'User'
  has_many :upvotes, class_name: 'VideoRequestUpvote', foreign_key: 'video_request_id'
end
