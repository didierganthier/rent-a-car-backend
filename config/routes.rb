Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :cars, only: [:index, :show, :create, :destroy]
  resources :reservations, only: [:index, :create, :destroy]
  post '/login', to:  "users#login"
  post '/signup', to:  "users#signup"
end
