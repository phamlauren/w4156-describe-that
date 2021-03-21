class AddPublishedFieldToDescriptionTrack < ActiveRecord::Migration[6.1]
  def change
    add_column :description_tracks, :published, :boolean
    change_column_null :description_tracks, :published, false
  end
end
