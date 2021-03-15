class DescriptionTracksController < ActionController::Base
    def new
        redirect_to("welcome#index")
    end
end
