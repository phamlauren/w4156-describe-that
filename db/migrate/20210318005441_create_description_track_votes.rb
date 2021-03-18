class CreateDescriptionTrackVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :description_track_votes do |t|
      t.references :desc_track, null: false, foreign_key: { to_table: :description_tracks }
      t.references :voter, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
