class GeneratedDescription < ApplicationRecord
  self.primary_key = "description_id"
  belongs_to :description, foreign_key: "description_id"
  belongs_to :voice

  def generate_tts_for_description
    # TODO: Call Google Cloud TTS API.
  end
end
