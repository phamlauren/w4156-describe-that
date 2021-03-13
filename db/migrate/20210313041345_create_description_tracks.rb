class CreateDescriptionTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :description_tracks do |t|
      t.references :video, null: false, foreign_key: true
      t.references :track_author, null: false, foreign_key: {to_table: :users}
      t.column :lang, "char(2)"
      t.boolean :is_generated

      t.timestamps
    end
  end
end
