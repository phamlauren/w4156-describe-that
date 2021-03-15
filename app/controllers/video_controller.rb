class VideoController < ApplicationController

  # Show the video and all of its descriptions
  def show
    # make GET request to YouTube API -> get yt_video_id
    # @video = Video.find(yt_video_id)
    @video = Video.find(params[:id])
    @description_track = DescriptionTrack.find_by('video_id': @video.id)
    @descriptions = Description.where(desc_track_id: @description_track.id)
    # renders app/view/video/show.html.erb by default
  end

  # Create a description
  def add_description
    # pass yt_video_id from show method
    # @video = Video.find(yt_video_id)
    @video = Video.find(params[:id])
    @description_track = DescriptionTrack.find_by('video_id': @video.id)
    # TO DO ------->
    # pass params to description model method to create descriptions
    #     with description.desc_track_id = @description_track.id
    # the generate tts method belonging to the description model
    #     may then be called from within the create description
    #     model method itself before returning here
    # <-------------
    # Get updated list of descriptions, including newly created one
    @descriptions = Description.where(desc_track_id: @description_track.id)
    # TO DO: then redirect to show path for this video
  end


end
  