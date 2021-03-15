require 'securerandom'

class Description < ApplicationRecord
  belongs_to :description_track, optional: true # optional: true is temporary for cucumber
                                                # remove for deploy and prod
  belongs_to :voice, optional: true
  enum desc_type: { recorded: "recorded", generated: "generated" }

  def self.generate_unique_name
    name = SecureRandom.uuid + ".wav"
    while Description.where(audio_file_loc: name).count > 0
      name = SecureRandom.uuid + ".wav"
    end
    name
  end
end
