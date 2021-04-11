# :nocov:
class DescriptionTrackCommentController < ApplicationController

  def comment
    # Get the description track and the user
    description_track = DescriptionTrack.find(params[:dtrack_id])
    user = User.find_by(auth0_id: session[:userinfo]['sub'])
    # Create the description track
    DescriptionTrackComment.create!(
      desc_track_id: description_track.id,
      comment_author_id: user.id,
      comment_text: params[:comment_text],
      parent_comment_id: params[:parent_comment_id]
    )
    # Redirect to the play page for the description track
    redirect_to "/video/#{description_track.video_id}/play/#{description_track.id}"
  end

end
# :nocov:
  