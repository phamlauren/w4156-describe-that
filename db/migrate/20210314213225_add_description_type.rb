class AddDescriptionType < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
        CREATE TYPE description_type AS ENUM ('recorded', 'generated');
    SQL
    add_column :descriptions, :desc_type, :description_type
  end

  def down
    remove_column :descriptions, :desc_type
    execute <<-SQL
        DROP TYPE description_type;
    SQL
  end
end
