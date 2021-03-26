class DescriptionController < ApplicationController
  def new_generated
    # may need to decide if needed to over write the track with same start time or not
    #@description = Description.create_with(pause_at_start_time: false, desc_type: 'generated', audio_file_loc: nil, desc_text: params[:description], voice_id: 2, voice_speed: 1.0).find_or_create_by!(desc_track_id: params[:track_id].to_i, start_time_sec: params[:time])
    #Description.where(desc_track_id: params[:track_id].to_i, start_time_sec: params[:time].to_f).destroy_all
    
    description = Description.create(pause_at_start_time: params[:pause_at_start_time]=="1" ? true : false, desc_type: 'generated', audio_file_loc: "", desc_text: params[:description], voice_id: params[:voice_id].to_i, voice_speed: params[:voice_speed].to_f, desc_track_id: params[:track_id].to_i, start_time_sec: params[:time].to_f)
    render :json => {id: description.id, url: description.generate_tts ? description.get_download_url_for_audio_file : ""}.to_json
  end

  # delete generated description from db and return to the front-end for edit
  def edit_generated
    d = Description.find(params[:desc_id].to_i)
    editable = {start_time_sec: d.start_time_sec, pause_at_start_time: d.pause_at_start_time ? "1" : "0", desc_text: d.desc_text, voice_id: d.voice_id, voice_speed: d.voice_speed}
    d.delete_file_from_s3
    Description.destroy(d.id)
    render :json => editable.to_json
  end

  def new_recorded
    ### audio content is in params[audio_content] -- check of this is nil before proceeding!
    if params[:audio_content]!=nil
      this_description_filename = Description.generate_unique_name
      audio_content_bytes = Base64.decode64(params[:audio_content])
      S3FileHelper.upload_file(this_description_filename, audio_content_bytes)
      description = Description.create(pause_at_start_time: params[:pause_at_start_time]=="1" ? true : false, desc_type: 'recorded', audio_file_loc: this_description_filename, desc_track_id: params[:track_id].to_i, start_time_sec: params[:time].to_f)
      render :json => {id: description.id, url: description.audio_file_loc ? description.get_download_url_for_audio_file : ""}.to_json
    end
  end

  def delete_recorded
    d = Description.find(params[:desc_id].to_i)
    d.delete_file_from_s3
    Description.destroy(d.id)
  end
end