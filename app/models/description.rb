require 'securerandom'

class Description < ApplicationRecord
  belongs_to :description_track
  belongs_to :voice, optional: true
  enum desc_type: { recorded: "recorded", generated: "generated" }

  # add validation to generated descriptions
  validates :desc_text, presence: true, if: -> {:desc_type == Description.desc_types[:generated]}
  validates :voice_id, presence: true, if: -> {:desc_type == Description.desc_types[:generated]}
  validates :voice_speed, presence: true, if: -> {:desc_type == Description.desc_types[:generated]}

  # other validations
  before_save :validate_audio_file_exists
  before_save :validate_required_fields_present_and_not_null_for_gen_desc

  def validate_audio_file_exists
    not audio_file_loc.nil? and not audio_file_loc.empty?
  end

  def validate_required_fields_present_and_not_null_for_gen_desc
    (:desc_type == Description.desc_types[:recorded]) \
    or
    (not desc_text.nil? and not desc_text.empty? \
      and not voice_id.nil? and Voice.exists?(id: voice_id) \
      and not voice_speed.nil? and voice_speed > 0)
  end


  def self.generate_unique_name
    name = SecureRandom.uuid + ".wav"
    while Description.where(audio_file_loc: name).count > 0
      name = SecureRandom.uuid + ".wav"
    end
    name
  end

  def generate_tts  # return bool indicating success
    false if desc_text.nil? or desc_text.empty?


  end
end
