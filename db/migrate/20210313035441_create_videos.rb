class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :yt_video_id
      t.boolean :deleted

      t.timestamps
    end
  end
end
