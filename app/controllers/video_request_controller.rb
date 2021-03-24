class VideoRequestController < ApplicationController

  def index
    @requests_info = []
    video_requests = VideoRequest.all.sort { |a, b| a.number_of_votes <=> b.number_of_votes }
    puts video_requests
    video_requests.each do |video_request|
        video = Video.find(video_request.video_id)
        puts video
        video_info = video.video_info
        # show video if we successfully get video info from youtube API
        if !video_info.empty?
        video_info["video_id"] = video.id
        video_info["vote_count"] = video_request.number_of_votes
        @requests_info.push(video_info)
        end
    end
  end

end
