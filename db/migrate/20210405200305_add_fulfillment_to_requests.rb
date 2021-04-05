class AddFulfillmentToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :video_requests, :is_fulfilled, :boolean, default: false
    change_column_null :video_requests, :is_fulfilled, false
  end
end
