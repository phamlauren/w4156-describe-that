Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/user', to: 'user#index'
  get '/user/new', to: 'user#new'
  post '/user', to: 'user#create'
  post '/user/login', to: 'user#login'
end
