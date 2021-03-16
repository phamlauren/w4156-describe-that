class AlterUniquenessInVoices < ActiveRecord::Migration[6.1]
  def change
    add_index :voices, :common_name, unique: true
    add_index :voices, [:system_name, :provider], unique: true
  end
end
