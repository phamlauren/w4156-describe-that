class AddUniqueIndexToRequestUpvote < ActiveRecord::Migration[6.1]
  def change
    add_index :video_request_upvotes, [:video_request_id, :upvoter_id], unique: true
  end
end
