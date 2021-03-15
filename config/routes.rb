Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'user#index'

  get '/video/:id', to: 'video#show'
  get '/user', to: 'user#index'
  get '/user/new', to: 'user#new'
  post '/user', to: 'user#create'
  get '/user/login', to: 'user#login_page'
  post '/user/login', to: 'user#login'
end
