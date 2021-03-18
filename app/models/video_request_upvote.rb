class VideoRequestUpvote < ApplicationRecord
  belongs_to :video_request
  belongs_to :upvoter, class_name: 'User'
end
