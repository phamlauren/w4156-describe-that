class AlterColumnVideoYtVideoId < ActiveRecord::Migration[6.1]
  def change
    add_index :videos, :yt_video_id, unique: true
  end
end
