class CreateDescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :descriptions do |t|
      t.references :desc_track, null: false, foreign_key: {to_table: :description_tracks}
      t.float :start_time_sec
      t.boolean :pause_at_start_time

      t.timestamps
    end
  end
end
