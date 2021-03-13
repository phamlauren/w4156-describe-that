class RemoveCreationTimeFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :creation_time, :datetime
  end
end
