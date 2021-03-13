class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.datetime :creation_time
      t.json :options

      t.timestamps
    end
  end
end
