require 'google/api_client'
require 'trollop'

class DescriptionTracksController < ActionController::Base
    def new
        match = /^(?:https:\/\/)?(?:www.youtube.com\/watch\?v=|youtu.be\/)([^?]+)(?:\?.*)?$/.match(params[:yt_url])
        ytid = match.captures[0]
        @ytid_is_valid = valid_ytid ytid
            
        end
    rescue NoMethodError
        # should not have a route without a YouTube URL
        redirect_to("video#index")
    end

    private
    def get_service
        client = Google::APIClient.new(
            :key => $DEVELOPER_KEY,
            :authorization => nil,
            :application_name => $PROGRAM_NAME,
            :application_version => '1.0.0'
        )
        youtube = client.discovered_api('youtube', 'v3')
        return client, youtube
    end

    def valid_ytid ytid
        client, youtube = get_service

    end
end
