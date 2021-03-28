class RemoveGeneratedAttributeFromDescriptionTrack < ActiveRecord::Migration[6.1]
  def change
    remove_column :description_tracks, :is_generated
  end
end
