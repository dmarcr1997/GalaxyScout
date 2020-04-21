Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/signin', to: 'sessions#new', as: 'signin'
  post '/sessions', to: "sessions#create"
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/users/signup', to:'users#new', as:'signup'
  post '/users', to: 'users#create'
  get '/users/:id', to:'users#show', as:'user'
  get '/', to:'sessions#show'
  # get '/albums', to:'albums#index', as:'all_albums'
  post '/comments', to: 'comments#create'
  get '/albums/:id/delete', to: 'albums#destroy'
  get '/auth/facebook/callback' => 'sessions#create'
  resources :albums do 
    resources :comments
    resources :galaxies, only: [:index, :new]
  
    resources :space_objs, only: [:index, :new]
    
    resources :planets, only: [:index, :new]
  end

  resources :galaxies, only: [:show, :create] 
  
  resources :space_objs, only: [:show, :create]

  resources :planets, only: [:show, :create]

end
