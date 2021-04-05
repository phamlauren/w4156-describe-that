class CreateVideoFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :video_favorites do |t|
      t.references :video, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
