class UserController < ApplicationController

  def index
    @users = User.all
  end

  def dashboard
    @user = User.find_by(auth0_id: session[:userinfo]['sub'])
    @requests = VideoRequest.where(requester_id: @user.id)
    @upvotes = VideoRequestUpvote.where(upvoter_id: @user.id)
    @comments = DescriptionTrackComment.where(comment_author_id: @user.id)
    @comments.each do |comment|
      puts comment.description_track
    end
  end
  
end
