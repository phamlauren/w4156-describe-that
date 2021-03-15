require 'httparty'
require 'json'

module GoogleCloudTtsHelper
  SYNTHESIZE_API_BASE_URL = "https://texttospeech.googleapis.com/v1beta1/text:synthesize?key="

  def self.synthesize(to_say, speech_rate, voice_name)
    target_url = SYNTHESIZE_API_BASE_URL + ENV["GOOGLE_TTS_API_KEY"]
    json_to_transmit = form_json(to_say, speech_rate, voice_name)
    resp = HTTParty.post(target_url, body: json_to_transmit, headers: {'Content-Type' => "application/json"})

    nil if resp.code != 200

    data = resp["audioContent"]
    audio_content_bytes = Base64.decode64(data)

    StringIO.new(audio_content_bytes)
  end

  # GoogleCloudTtsHelper.synthesize("This is a test sentence.", 1.0, "en-US-Wavenet-F")
  # puts Dir.getwd
  # File.open('out.wav', 'wb') do |f|
  #   f.puts(io.read)
  # end

  private
  def self.form_json(to_say, speech_rate, voice_name)
    {
      "input": {
        "text": to_say
      },

      "audioConfig": {
        "speakingRate": speech_rate,
        "effectsProfileId": [ "headphone-class-device" ],
        "audioEncoding": "LINEAR16",
        "sampleRateHertz": 22050
      },

      "voice": {
        "name": voice_name,
        "languageCode": voice_name[0, 5]
      }
    }.to_json
  end
end
