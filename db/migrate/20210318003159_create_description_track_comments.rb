class CreateDescriptionTrackComments < ActiveRecord::Migration[6.1]
  def change
    create_table :description_track_comments do |t|
      t.references :desc_track, null: false, foreign_key: { to_table: :description_tracks }
      t.references :comment_author, null: false, foreign_key: { to_table: :users }
      t.text :comment_text
      t.references :parent_comment, null: true, foreign_key: { to_table: :description_track_comments }

      t.timestamps
    end
  end
end
