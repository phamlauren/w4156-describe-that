class AddUniqueIndexToVideoRequest < ActiveRecord::Migration[6.1]
  def change
    add_index :video_requests, [:video_id, :requested_lang], unique: true
  end
end
