require 'http'
require 'json'
class DescriptionTracksController < ActionController::Base
    def new
        # get yt_id
        yt_id = params.key?(:yt_id) ? params[:yt_id] : nil
        if yt_id == nil
            match = /^(?:https:\/\/)?(?:www.youtube.com\/watch\?v=|youtu.be\/)([^?]+)(?:\?.*)?$/.match(params[:yt_url])
            yt_id = match.captures[0]
        end
        # get yt_info
        @yt_info = video_info yt_id
        @yt_info != {} ? render('new') : render('new_fail')
    rescue NoMethodError
        # should not have a route without a YouTube URL
        redirect_to("video#index")
    end

    private
    # parse the ytid from url without validation
    def get_ytid_from_url(url)
        match = /^(?:https:\/\/)?(?:www.youtube.com\/watch\?v=|youtu.be\/)([^?]+)(?:\?.*)?$/.match(params[:yt_url])
        if match == nil
            return nil
        return match.captures[0]
    end
    # get useful info for video, if return {} then the ytid is invalid
    def video_info(ytid)
        response = HTTP.get("https://youtube.googleapis.com/youtube/v3/videos", :params => {:part => "snippet", :id => ytid, :key => ENV["YT_API_KEY"]})
        result = JSON.parse(response)
        return result["items"].length()==1 ? result["items"][0]["snippet"] : {}
    end
end
