class DescriptionTrackController < ApplicationController
    def switch_published
        track = DescriptionTrack.find(params[:id])
        track.published = params[:published]=="true" ? true : false
        track.save
    end
end