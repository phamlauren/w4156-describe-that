class CreateVoices < ActiveRecord::Migration[6.1]
  def change
    create_table :voices do |t|
      t.string :common_name, :unique => true
      t.string :system_name
      t.string :provider
    end
  end
end
