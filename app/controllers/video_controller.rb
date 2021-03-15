require 'http'
require 'json'
class VideoController < ApplicationController

  def index
    # handle the YouTube and get redirect
    if params[:commit] == "Describe" && params[:yt_url]!=nil
      ytid = get_ytid_from_url params[:yt_url]
      if video_info(ytid) != {}
        video = Video.find_or_create_by(yt_video_id: ytid)
        id = video.id
        # if the url is valid then redirect
        redirect_to action: "show", id: id
      else
        # if not valid, then redirect to err page
        @err = "Sorry, we couldn't find a video with that YouTube link."
        render "err"
      end
    end
  end

  # Show the video and all of its descriptions
  def show
    # make GET request to YouTube API -> get yt_video_id
    # if there's only a params[:yt_url] then we need to get one video id
    begin
      if params[:id] == nil
        raise ActiveRecord::RecordNotFound.new "No id"
      else
        @video = Video.find(params[:id])
      end
    rescue ActiveRecord::RecordNotFound
      @err = "Sorry, we couldn't find a video with that YouTube link."
      @video_id = params[:id]
      render "err"
    else
      @description_tracks = DescriptionTrack.where('video_id': @video.id)
      @desc_track_ids = @description_tracks.pluck(:id)
      @descriptions =  Description.where('desc_track_id': @desc_track_ids)
      @yt_info = video_info @video.yt_video_id
      render "request_video" if @descriptions.empty?
    end
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

  def request_video
    @video = Video.find(params[:id])
    flash[:notice] = "This feature is not implemented yet. But if it was, you would have been notified: 'You have successfully requested AD for this video.'"
    redirect_to video_path
  end

  def describe
    # input: params[:id]
    render "describe"
  end

  private
  # parse the ytid from url without validation
  def get_ytid_from_url(url)
    match = /^(?:https:\/\/)?(?:www.youtube.com\/watch\?v=|youtu.be\/)([^?]+)(?:\?.*)?$/.match(params[:yt_url])
    return match == nil ? nil : match.captures[0]
  end
  # get useful info for video, if return {} then the ytid is invalid
  def video_info(ytid)
    return {} if ytid == nil
    puts "no env key" if ENV["YT_API_KEY"]==nil
    response = HTTP.get("https://youtube.googleapis.com/youtube/v3/videos", :params => {:part => "snippet", :id => ytid, :key => ENV["YT_API_KEY"]})
    result = JSON.parse(response)
    return result["items"].length()==1 ? result["items"][0]["snippet"] : {}
  end

end
  
