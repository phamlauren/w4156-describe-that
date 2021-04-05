class AddUniqueIndexToVideoFavorite < ActiveRecord::Migration[6.1]
  def change
    add_index :video_favorites, [:video_id, :user_id], unique: true
  end
end
