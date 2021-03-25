class DescriptionController < ApplicationController
  def new_generated
    voice = Voice.find_or_create_by(common_name: "Voice US A", system_name: "en-US-Wavenet-A", provider: "google_tts")
    @description = Description.create_with(pause_at_start_time: false, desc_type: 'generated', audio_file_loc: "", desc_text: params[:description], voice_id: 2, voice_speed: 1.0).find_or_create_by!(desc_track_id: params[:track_id].to_i, start_time_sec: params[:time])
    #puts @description.generate_tts
    puts @description.audio_file_loc
    puts @description.get_download_url_for_audio_file
    #render :text => @description.generate_tts ? @description.get_download_url_for_audio_file : ""
  end
end