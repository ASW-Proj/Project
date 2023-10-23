Rails.application.routes.draw do
  
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
  
  # Route to view a single post
  get "/posts/:id" => "posts#show", as: :show_post

end
