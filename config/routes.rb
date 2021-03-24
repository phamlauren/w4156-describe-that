Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'video#index'

  get '/video/recent', to: 'video#recently_accessed'
  get '/video', to: 'video#fetch_from_api'
  get '/video/:id', to: 'video#show'
  get 'video/:id/describe', to: 'video#describe'
  post 'video/:id/describe', to: 'video#describe'
  post '/video/:id/request', to: 'video#request_video'
  get '/user', to: 'user#index'
  get '/user/new', to: 'user#new'
  post '/user', to: 'user#create'
  get '/user/login', to: 'user#login_page'
  post '/user/login', to: 'user#login'

  get '/coverage', :to => redirect('/index.html')
end
