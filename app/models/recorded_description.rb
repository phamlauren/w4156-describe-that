class RecordedDescription < ApplicationRecord
  self.primary_key = "description_id"
  belongs_to :description, foreign_key: "description_id"
end
