class DescriptionTracksController < ActionController::Base
    def new
        match = /^(?:https:\/\/)?(?:www.youtube.com\/watch\?v=|youtu.be\/)([^?]+)(?:\?.*)?$/.match(params[:yt_url])
        vid = match.captures[0]
        redirect_to("welcome#index")
    rescue NoMethodError
        # should not have a route without a YouTube URL
        redirect_to("welcome#index")
    end
end
