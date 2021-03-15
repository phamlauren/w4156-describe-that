require 'http'
require 'json'
class DescriptionTracksController < ActionController::Base
    def new
        yt_id = params.key?(:yt_id) ? params[:yt_id] : nil
        if yt_id == nil
            match = /^(?:https:\/\/)?(?:www.youtube.com\/watch\?v=|youtu.be\/)([^?]+)(?:\?.*)?$/.match(params[:yt_url])
            yt_id = match.captures[0]
        end
        @yt_info = video_info yt_id
        @yt_info != {} ? render('new') : render('new_fail')
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
