require 'http'
require 'json'
class DescriptionTracksController < ActionController::Base
    def new
        match = /^(?:https:\/\/)?(?:www.youtube.com\/watch\?v=|youtu.be\/)([^?]+)(?:\?.*)?$/.match(params[:yt_url])
        ytid = match.captures[0]
        yt_info = video_info ytid
        #@ytid_is_valid = yt_info != {}
        puts yt_info
        redirect_to("video#index")
    rescue NoMethodError
        # should not have a route without a YouTube URL
        redirect_to("video#index")
    end

    private

    def video_info(ytid)
        response = HTTP.get("https://youtube.googleapis.com/youtube/v3/videos", :params => {:part => "snippet", :id => ytid, :key => ENV["YT_API_KEY"]})
        result = JSON.parse(response)
        return result["items"].length()==1 ? result["items"][0]["snippet"] : {}
    end
end
