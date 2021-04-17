class AddAdditionalVoiceMetadata < ActiveRecord::Migration[6.1]
  def change
    add_column :voices, :language_code, :string
    add_column :voices, :country_code, :string
    add_column :voices, :gender, :string
    add_column :voices, :natural_sample_rate_hz, :integer

    change_column_default :voices, :natural_sample_rate_hz, 22050
    change_column_null    :voices, :natural_sample_rate_hz, false
  end
end
