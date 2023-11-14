Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get '/users/auth/google_oauth2/callback', to: 'users/omniauth_callbacks#google_oauth2'
    get '/logout', to: 'users/sessions#destroy', as: :logout
  end

  resources :communities
  get "up" => "rails/health#show", as: :rails_health_check

  # Resources for posts and comments
  resources :posts do
    resources :comments, only: [:create]
  end

  # Search route
  get 'search', to: 'search#index'
  get 'search/index'
resources :users
  # User routes
  resources :users, only: [:show] do
    member do
      get 'posts', to: 'users#show', content_type: 'Publicaciones', as: 'user_posts'
      get 'comments', to: 'users#comments', as: 'user_comments'
    end
  end
  get '/home_newt_posts', to: 'posts#home_newt', as: :home_newt_posts
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # Root route
  root 'posts#home'
end
