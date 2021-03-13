class CreateGeneratedDescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :generated_descriptions, id: false do |t|
      t.primary_key :description_id
      t.string :audio_file_loc
      t.text :description_text
      t.references :tts_voice, null: false, foreign_key: {to_table: :voices}
      t.float :tts_speed

      t.timestamps
    end
  end
end
