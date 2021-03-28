class DescriptionTrackComment < ApplicationRecord
  belongs_to :description_track, foreign_key: 'desc_track_id'#, optional: true # for some reason seeder couldn't detect existing DT
  belongs_to :comment_author, class_name: 'User', foreign_key: 'comment_author_id'#, optional: true

  belongs_to :parent_comment, class_name: 'DescriptionTrackComment', foreign_key: 'parent_comment_id', optional: true
  has_many :replies, class_name: 'DescriptionTrackComment', foreign_key: "parent_comment_id"
end
