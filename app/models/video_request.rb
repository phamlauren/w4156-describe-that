class VideoRequest < ApplicationRecord
  belongs_to :video
  belongs_to :requester, class_name: 'User'
end
