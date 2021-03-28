Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'video#index'

  # Video
  get '/video/undescribed', to: 'video#index_undescribed'
  get '/video', to: 'video#fetch_from_api'
  get '/video/:id', to: 'video#show'
  get 'video/:id/describe', to: 'video#describe'
  post 'video/:id/describe', to: 'video#describe'
  post '/video/:id/request', to: 'video#request_video'
  post '/video/:id/comment', to: 'video#comment'

  # Video request
  get '/video_requests', to: 'video_request#index'
  get '/video_requests/:id', to: 'video_request#upvote_request'

  # User
  get '/user', to: 'user#index'

  # Auth0
  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'

  get '/coverage', :to => redirect('/index.html')
end

