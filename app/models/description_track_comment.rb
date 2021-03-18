class DescriptionTrackComment < ApplicationRecord
  belongs_to :description_track
  belongs_to :comment_author, class_name: 'User'

  belongs_to :parent_comment, class_name: 'DescriptionTrackComment', optional: true
  has_many :replies, class_name: 'DescriptionTrackComment', foreign_key: "parent_comment_id", optional: true
end
