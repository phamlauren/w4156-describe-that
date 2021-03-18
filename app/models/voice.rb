class Voice < ApplicationRecord
  has_many :descriptions_that_use_voice, class_name: "Description", foreign_key: "voice_id"

  def self.get_all_voices_for_provider(provider)
    Voice.where(provider: provider).to_a
  end

  def self.get_system_label_using_common_label(cname)
    result = Voice.find_by(common_name: cname)
    result if result.nil?
    result.system_name
  end
end
