class CreateVideoRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :video_requests do |t|
      t.references :video, null: false, foreign_key: true
      t.column :requested_lang, "char(2)"
      t.references :requester, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
