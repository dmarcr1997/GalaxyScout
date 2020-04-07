Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/sessions/new', to: 'sessions#new', as: 'signin'
  post '/sessions', to: "session#create"

  get '/users/new', to:'users#signup', as:'signup'
  post '/users', to: 'users#create'
  get '/users/:id', to:'users#show', as:'homepage'

  resources :albums
  
  resources :galaxies, only: [:index, :show, :new, :create]
  
  resources :solar_systems, only: [:index, :show, :new, :create]
  
  resources :planets, only: [:index, :show, :new, :create]
  
end
