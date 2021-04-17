class AddLengthFieldToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :length_sec, :integer
    change_column_default :videos, :length_sec, 3600
    change_column_null :videos, :length_sec, false
  end
end
