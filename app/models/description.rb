class Description < ApplicationRecord
  belongs_to :description_track
  belongs_to :voice, optional: true
  enum desc_type: { recorded: "recorded", generated: "generated" }
end
