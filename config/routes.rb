Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/signin', to: 'sessions#new', as: 'signin'
  post '/sessions', to: "sessions#create"
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/users/signup', to:'users#new', as:'signup'
  post '/users', to: 'users#create'
  get '/users/:id', to:'users#show', as:'user'
  get '/', to:'sessions#show'
  get '/albums/:id/delete', to:'albums#destroy', as: 'delete_album'
  resources :albums
  
  resources :galaxies, only: [:index, :show, :new, :create]
  
  resources :space_objs, only: [:index, :show, :new, :create]
  
  resources :planets, only: [:index, :show, :new, :create]
  
end
