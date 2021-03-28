require 'http'
require 'json'
class VideoController < ApplicationController

  # All of the video records that have a published DescriptionTrack
  def index
    puts session[:userinfo]
    @videos_info = []
    @videos = Video.all
    @videos.each do |video|
      video_info = video.video_info
      # show if video has description track and if we successfully get video info from youtube API
      if video.has_published_desc_track && !video_info.empty?
        video_info["id"] = video.id
        @videos_info.push(video_info)
      end
    end
  end

  # All of the video records, including those without DescriptionTracks
  # Because we add a video once we get it from the API the first time someone
  # Enters the URL
  def index_undescribed
    @videos_info = []
    @videos = Video.all
    @videos.each do |video|
      video_info = video.video_info
      # show if video has no description track and if we can successfully get video info from youtube API
      if !video.has_published_desc_track && !video_info.empty?
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
      @all_tracks = DescriptionTrack.where(video_id: @video.id)
      @yt_info = @video.video_info
      @langs = build_lang_list
      render "request_video" if @all_tracks.empty?
    end
  end

  def request_video
    video = Video.find(params[:id])
    video_request = VideoRequest.find_by(video_id: video.id)
    user = User.find_by(auth0_id: session[:userinfo]['sub'])
    # if a request does not exist, then make one
    if !video_request
      VideoRequest.create!(video_id: video.id, requested_lang:'en', requester_id: user.id)
      flash[:notice] = "You request has been saved!"
    # if a request exists and the user has not already upvoted, then upvote
    elsif !VideoRequestUpvote.exists?(video_request_id: video_request.id, upvoter_id: user.id)
      VideoRequestUpvote.create!(video_request_id: video_request.id, upvoter_id: user.id)
      flash[:notice] = "You request has been saved!"
    # else request exists and the user has already upvoted
    else
      flash[:notice] = "You have already requested this video."
    end

    redirect_to '/video_requests'
  end

  def describe
    #user = User.find_or_create_by(auth0_id: "drowssap")
    user = User.find_by(auth0_id: session[:userinfo]['sub'])
    # create or load the track for this video and this user
    # by default, generated is true and published is false, we need to modify it later when user clicks buttons

    # if a description track was not specified...
    if params[:dtrack_id].nil?
      @track = DescriptionTrack.create(published: false, video_id: params[:id], track_author_id: user.id)
    else
      # try to look for the specified track
      this_track = DescriptionTrack.where(id: params[:dtrack_id]).first
      if this_track.nil?
        @track = DescriptionTrack.create(published: false, video_id: params[:id], track_author_id: user.id)
      else
        @track = this_track
      end
    end

    if request.get?
      # input: params[:id]
      # create only when there is **no** description track for the video
      # might change that later!
      redirect_to "/video/#{params[:id]}/describe" if params[:id] == nil
      @video = Video.find(params[:id])
      @yt_info = video_info @video.yt_video_id
      @voices = Voice.all.map { |v| [v.common_name, v.id] }
      @langs = build_lang_list
      @descriptions = @track.get_all_descriptions.map { |d| {id: d.id, start_time_sec: d.start_time_sec, url: d.get_download_url_for_audio_file, generated: d.desc_type=='generated', inline_extended: d.pause_at_start_time ? "extended" : "inline"} }
    end
    if request.post?
      redirect_to video_path(params[:id]) if params[:id] == nil
      # save time and description
      ###
      @track.published = true
      @track.save
      redirect_to "/video/#{params[:id]}"
    end
  end

  def delete_description_track
    # redirect to video page if not logged in
    redirect_to "/video/#{params[:id]}" if session[:userinfo].nil?

    this_user = User.find_by(auth0_id: session[:userinfo]['sub'])
    this_description_track = DescriptionTrack.find_by(id: params[:dtrack_id])

    # redirect to video page if we can't find the requested user or description track
    redirect_to "/video/#{params[:id]}" if this_description_track.nil? or this_user.nil?

    dt_owner_id = this_description_track.track_author_id

    # if this user is the owner of this description track...
    if dt_owner_id == this_user.id
      # delete each description's audio file from S3 and destroy the DB entry
      all_descriptions_under_this_track = Description.where(desc_track_id: this_description_track.id)
      all_descriptions_under_this_track.each do |d|
        S3FileHelper.delete_file(d.audio_file_loc)
        d.destroy
      end

      # then destroy the entry for this description track
      this_description_track.destroy
    end

    # go back to the video page
    redirect_to "/video/#{params[:id]}"
  end

  def play
    if request.get?
      # input: params[:id]
      # create only when there is **no** description track for the video
      # might change that later!
      redirect_to root_path if params[:id].nil? or params[:dtrack_id].nil?

      begin
        @video = Video.where(id: params[:id]).first!
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path
        return
      end

      @yt_info = video_info @video.yt_video_id

      begin
        @track = DescriptionTrack.where(id: params[:dtrack_id]).first!
      rescue ActiveRecord::RecordNotFound
        redirect_to "/video/#{params[:id]}"
        return
      end

      @descriptions = @track.get_all_descriptions.map { |d| {id: d.id, start_time_sec: d.start_time_sec, url: d.get_download_url_for_audio_file, generated: d.desc_type=='generated', inline_extended: d.pause_at_start_time ? "extended" : "inline"} }
      render "play"
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

  def build_lang_list
    all_langs = LanguageList::COMMON_LANGUAGES.collect { |l_info| [l_info.name, l_info.iso_639_1] }
    all_langs.insert(0, ['---', '---'])
    this_index = all_langs.index { |l_info| l_info[0] == "English" }
    all_langs.insert(0, all_langs.delete_at(this_index))
    all_langs
  end
end
  
