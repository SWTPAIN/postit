PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'  #It came with named route register even thought I didint explictily said as'...'' check it by rake routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'  # Not using resoruces because we dont need CRUD


  resources :posts, except: :destroy do
    resources :comments, only: [:create]
  end
  resources :categories, only: [:create, :show, :new]
  resources :users, only: [:create, :edit, :update, :show]
end
