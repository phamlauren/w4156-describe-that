require 'http'
require 'json'
class VideoController < ApplicationController

  def index
    @videos_info = []
    @videos = Video.all
    @videos.each do |video|
      video_info = video_info video.yt_video_id
      # don't show video if we can't get video info
      if !video_info.empty?
        video_info["id"] = video.id
        @videos_info.push(video_info)
      end
    end
  end

  def fetch_from_api
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
      description_tracks = DescriptionTrack.where(video_id: @video.id)
      desc_track_ids = description_tracks.pluck(:id)
      @descriptions =  Description.where(desc_track_id: desc_track_ids)
      @yt_info = video_info @video.yt_video_id
      render "request_video" if @descriptions.empty?
    end
  end

  def request_video
    @video = Video.find(params[:id])
    flash[:notice] = "This feature is not implemented yet. But if it was, you would have been notified: 'You have successfully requested AD for this video.'"
    redirect_to '/'
  end

  def describe
    if request.get?
      # input: params[:id]
      # create only when there is **no** description track for the video
      # might change that later!
      @video = Video.find(params[:id])
      @yt_info = video_info @video.yt_video_id
      # get user here!
      user = User.find_or_create_by(email: "xw2765@columbia.edu", password: "drowssap")
      # create or load the track for this video and this user
      @track = DescriptionTrack.find_or_create_by!(video_id: params[:id], track_author_id: user.id, is_generated: true)
      redirect_to video_path(params[:id]) if params[:id] == nil || DescriptionTrack.find_by(video_id: params[:id])
    end
    if request.post?
      redirect_to video_path(params[:id]) if params[:id] == nil
      # save time and description

      ### audio content is in params[audio_content] -- check of this is nil before proceeding!
      # this_description_filename = Description.generate_unique_name
      # audio_content_bytes = Base64.decode64(params[:audio_content])
      # S3FileHelper.upload_file(this_description_filename, audio_content_bytes)
      ###
      track.generate_descriptions(params[:time],params[:description])
      redirect_to "/video/#{params[:id]}"
    end
  end

  private
  # parse the ytid from url without validation
  def get_ytid_from_url(url)
    match = /^(?:https:\/\/)?(?:www.youtube.com\/watch\?v=|youtu.be\/)([^?&]+)(?:[\?|&].*)?$/.match(params[:yt_url])
    return match == nil ? nil : match.captures[0]
  end
  # get useful info for video, if return {} then the ytid is invalid
  def video_info(ytid)
    return {} if ytid == nil
    raise "no env key for YouTube!" if ENV["YT_API_KEY"]==nil
    response = HTTP.get("https://youtube.googleapis.com/youtube/v3/videos", :params => {:part => "snippet", :id => ytid, :key => ENV["YT_API_KEY"]})
    result = JSON.parse(response)
    return result["items"].length()==1 ? result["items"][0]["snippet"] : {}
  end

end
  
