Rails.application.routes.draw do
  get 'comments/like/:id', to: 'comments#like'
  post 'comments/like/:id', to: 'comments#like'
  get 'posts/like/:id', to: 'posts#like'
  post 'posts/like/:id', to: 'posts#like'

  get 'comments/dislike/:id', to: 'comments#dislike'
  post 'comments/dislike/:id', to: 'comments#dislike'
  get 'posts/dislike/:id', to: 'posts#dislike'
  post 'posts/dislike/:id', to: 'posts#dislike'


  get 'posts/comments/delete/:id', to: 'comments#destroy'
  delete 'posts/comments/delete/:id', to: 'comments#destroy'
  get 'comments/:id/edit', to: 'comments#edit'
  put 'comments/:id/edit', to: 'comments#update'

  get 'posts/delete/:id', to: 'posts#destroy'
  delete 'posts/delete/:id', to: 'posts#destroy'
  get 'posts/:id/edit', to: 'posts#edit'
  put 'posts/:id/edit', to: 'posts#update'







  resources :comments
  get 'posts/:id/comments', to: 'comments#new'
  post 'posts/:id/comments', to: 'comments#new'
  get 'pages/home'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :postuser do
    get '/users/auth/google_oauth2/callback', to: 'users/omniauth_callbacks#google_oauth2'
    get '/logout', to: 'users/sessions#destroy', as: :logout
  end

  # Resources for subscriptions
  get "/subscribe/:community_id", to: "subscriptions#create", as: "subscribe"
  get "/unsubscribe/:community_id", to: "subscriptions#destroy", as: "unsubscribe"

  # Resources for saved posts
  get "/save_post/:post_id", to: "saved_posts#create", as: "save_post"
  get "/unsave_post/:post_id", to: "saved_posts#destroy", as: "unsave_post"

  # Resources for saved comments
  get "/save_comment/:comment_id", to: "saved_comments#create", as: "save_comment"
  get "/unsave_comment/:comment_id", to: "saved_comments#destroy", as: "unsave_comment"

  # Resources for communities
  resources :communities

  get "up" => "rails/health#show", as: :rails_health_check


  # Resources for posts and comments

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

  #get '/list_saved_items', to: 'saved_items#list_saved_items', as: 'list_saved_items'
  get '/home', to: 'posts#home', as: 'frontpage'
  # Root route
  root 'posts#home'
end
