class ConsolidateDescriptionModel < ActiveRecord::Migration[6.1]
  def change
    # create new common fields in description model
    add_column :descriptions, :audio_file_loc, :string
    add_column :descriptions, :desc_text, :text

    # create generated description-specific fields
    add_reference :descriptions, :voice, foreign_key: true
    add_column :descriptions, :voice_speed, :float

    # create null statuses and defaults
    change_column_null :descriptions, :audio_file_loc, false
    change_column_null :descriptions, :desc_text, true
    change_column_null :descriptions, :voice_speed, true

    # deleted recorded and generated description tables
    drop_table :generated_descriptions
    drop_table :recorded_descriptions
  end
end
