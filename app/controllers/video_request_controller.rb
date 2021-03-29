class VideoRequestController < ApplicationController

  def index
    @requests_info = []
    video_requests = VideoRequest.all.sort { |b, a| a.number_of_votes <=> b.number_of_votes }
    video_requests.each do |video_request|
        video = Video.find(video_request.video_id)
        video_info = video.video_info
        # show video if we successfully get video info from youtube API
        if !video_info.empty?
        video_info["id"] = video_request.id
        video_info["video_id"] = video.id
        video_info["vote_count"] = video_request.number_of_votes
        @requests_info.push(video_info)
        end
    end
  end

  def upvote_request
    video_request = VideoRequest.find(params[:id])
    # TODO : user id of the person logged in
    user = User.find_by(auth0_id: session[:userinfo]['sub'])
    # if the user is not the requester and has not already upvoted, then upvote
    if video_request.requester_id != user.id && !VideoRequestUpvote.exists?(video_request_id: video_request.id, upvoter_id: user.id)
      VideoRequestUpvote.create!(video_request_id: video_request.id, upvoter_id: user.id)
      flash[:notice] = "Your request has been saved!"
    # else the user has already upvoted
    else
      flash[:notice] = "You have already requested this video."
    end
    redirect_to '/video_requests'
  end

end
