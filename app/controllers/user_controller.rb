class UserController < ApplicationController

  def index
    @users = User.all
  end

  def dashboard
    # Test with background seeded user having sub = auth0_id = abcde
    session[:userinfo]['sub'] = "asdffdsa" if Rails.env.test?
    @user = User.find_by(auth0_id: session[:userinfo]['sub'])
    @requests = VideoRequest.where(requester_id: @user.id)
    @upvotes = VideoRequestUpvote.where(upvoter_id: @user.id)
    @comments = DescriptionTrackComment.where(comment_author_id: @user.id)
  end
  
end
