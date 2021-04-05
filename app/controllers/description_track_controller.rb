class DescriptionTrackController < ApplicationController
    def switch_published
        track = DescriptionTrack.find(params[:id])
        track.published = params[:published]=="true" ? true : false
        track.save
    end

    def vote
        desc_track = DescriptionTrack.find(params[:id])
        puts desc_track.id
        session[:userinfo] = {"sub"=>"fdsaasdf"} if Rails.env.test?
        user = User.find_by(auth0_id: session[:userinfo]['sub'])
        # if the user has not already upvoted, then upvote
        if !DescriptionTrackVote.exists?(desc_track_id: desc_track.id, voter_id: user.id)
            DescriptionTrackVote.create!(desc_track_id: desc_track.id, voter_id: user.id)
          flash[:notice] = "Your vote has been saved!"
        # else the user has already upvoted
        else
          flash[:notice] = "You have already voted on this video."
        end
        redirect_to "/video/#{desc_track.video_id}/play/#{desc_track.id}"
    end
end