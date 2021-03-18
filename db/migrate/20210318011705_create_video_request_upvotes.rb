class CreateVideoRequestUpvotes < ActiveRecord::Migration[6.1]
  def change
    create_table :video_request_upvotes do |t|
      t.references :video_request, null: false, foreign_key: true
      t.references :upvoter, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
