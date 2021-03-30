Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'video#index'

  # Video
  get '/video/undescribed', to: 'video#index_undescribed'
  get '/video', to: 'video#fetch_from_api'
  get '/video/:id', to: 'video#show'
  get '/video/:id/describe', to: 'video#describe'
  post '/video/:id/describe', to: 'video#describe'
  post '/video/:id/request', to: 'video#request_video'

  get '/video/:id/play/:dtrack_id', to: 'video#play'
  get '/comment', to: 'description_track_comment#comment'

  get '/video/:id/describe/:dtrack_id', to: 'video#describe'
  post '/video/:id/describe/:dtrack_id', to: 'video#describe'
  get '/video/:id/delete/:dtrack_id', to: 'video#delete_description_track'

  # Description
  post '/description/new_generated', to: 'description#new_generated', as: 'new_generated'
  post '/description/new_recorded', to: 'description#new_recorded', as: 'new_recorded'
  post '/description/edit_generated', to: 'description#edit_generated', as: 'edit_generated'
  post '/description/delete_recorded', to: 'description#delete_recorded', as: 'delete_recorded'

  # Description track
  post '/description_track/:id/switch_published', to: 'description_track#switch_published'

  # Video request
  get '/video_requests', to: 'video_request#index'
  get '/video_requests/:id', to: 'video_request#upvote_request'

  # User
  get '/user', to: 'user#index'
  get '/dashboard', to: 'user#dashboard'

  # Auth0
  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'

  get '/coverage', :to => redirect('/index.html')
end

