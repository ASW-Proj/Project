Rails.application.routes.draw do
  get 'comments/like/:id', to: 'comments#like'
  post 'comments/like/:id', to: 'comments#like'
  get 'comments/dislike/:id', to: 'comments#dislike'
  post 'comments/dislike/:id', to: 'comments#dislike'
  get 'post/like/:id', to: 'post#like'
  post 'post/like/:id', to: 'post#like'
  get 'post/dislike/:id', to: 'post#dislike'
  post 'post/dislike/:id', to: 'post#dislike'
  resources :comments do
    member do
      post 'like'
      post 'dislike'
    end
  end

  post 'comments/:id/likes', to: 'comments#like', as: 'comment_like'
  delete 'comments/:id/likes', to: 'comments#dislike', as: 'comment_dislike'
  resources :comments
  get 'pages/home'

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
    resources :comments, only: [:create, :destroy]
    
    member do
      post 'vote_up'
      post 'vote_down'
    end
  end
  resources :posts do
    resources :comments 
  end
  resources :posts do
    resources :comments, only: [:create, :new, :destroy] do
      post '/reply/:parent_id', to: 'comments#reply', on: :collection, as: :reply
    end
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

  post '/save_post/:post_id', to: 'saved_items#save_post', as: 'save_post'
  post '/save_comment/:comment_id', to: 'saved_items#save_comment', as: 'save_comment'
  get '/list_saved_items', to: 'saved_items#list_saved_items', as: 'list_saved_items'
  # Root route
  root 'posts#home'
end
