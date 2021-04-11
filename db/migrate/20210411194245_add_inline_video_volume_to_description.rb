class AddInlineVideoVolumeToDescription < ActiveRecord::Migration[6.1]
  def change
    add_column :descriptions, :video_volume_inline, :float
    change_column_null :descriptions, :video_volume_inline, true
  end
end
