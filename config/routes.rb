Rails.application.routes.draw do

  root 'welcome#home'


  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  # post "/sessions/create", to: "sessions#create"
  # delete '/signout',  to: 'sessions#destroy'
  delete '/logout',  to: 'sessions#destroy'

  # get  '/signup',  to: 'users#new'
  # get '/users#new', as: "signup"

  post "/rides/new", to: "rides#create", as: "new_ride"

  resources :attractions

  resources :users

end
