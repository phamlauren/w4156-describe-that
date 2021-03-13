class CreateRecordedDescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :recorded_descriptions, id: false do |t|
      t.primary_key :description_id
      t.string :audio_file_loc
      t.text :description_text

      t.timestamps
    end
  end
end
