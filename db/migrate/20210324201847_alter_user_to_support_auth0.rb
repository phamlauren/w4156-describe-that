class AlterUserToSupportAuth0 < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :email
    remove_column :users, :password
    add_column :users, :username, :string
    add_column :users, :auth0_id, :string
  end
end
