class DescriptionTrack < ApplicationRecord
  belongs_to :video
  belongs_to :author, class_name: "User", foreign_key: "track_author_id"#  optional: true # optional: true is temporary for cucumber
                                                                                          # remove for deploy and prod
  has_many :descriptions, class_name: "Description", foreign_key: 'desc_track_id'
  has_many :votes, class_name: 'DescriptionTrackVote', foreign_key: "desc_track_id"
  has_many :comments, class_name: 'DescriptionTrackComment', foreign_key: "desc_track_id"

  def get_all_descriptions
    Description.where(desc_track_id: id).order('start_time_sec ASC').to_a
  end

  def get_all_root_comments
    DescriptionTrackComment.where(desc_track_id: id, parent_comment_id: nil)
  end

end
