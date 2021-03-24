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

  # Video request
  get '/video_requests', to: 'video_request#index'
  get '/video_requests/:id', to: 'video_request#upvote_request'

  # User
  get '/user', to: 'user#index'
  get '/user/new', to: 'user#new'
  post '/user', to: 'user#create'
  get '/user/login', to: 'user#login_page'
  post '/user/login', to: 'user#login'

  get '/coverage', :to => redirect('/index.html')
end
