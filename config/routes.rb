Rails.application.routes.draw do
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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"


  # ...................................................................... #
  # To create a post, we call the create function from the posts controller.
  #get "/create_post", to: "posts#create", as: :post
  resources :posts
  resources :posts do
    resources :comments, only: [:create]
  end

  get 'search', to: 'search#index'


  resources :users, only: [:show] do
    member do
      get 'posts', to: 'users#show', content_type: 'Publicaciones', as: 'user_posts'
      get 'comments', to: 'users#comments', as: 'user_comments'
    end
  end

  get 'search/index'

  resources :users

  # Route to view a single post
  get "/posts/:id" => "posts#show", as: :show_post

  get '/buscar', to: 'posts#buscar'

  root 'posts#home'
end
