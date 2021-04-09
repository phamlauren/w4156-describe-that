class AddDefaultToPublishedForDescriptionTrack < ActiveRecord::Migration[6.1]
  def change
    change_column_default :description_tracks, :published, false
  end
end
