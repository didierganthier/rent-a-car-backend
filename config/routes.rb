Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :cars, only: [:index, :show, :create, :destroy]
  resources :reservations, only: [:index, :create, :destroy]
  post '/login', to:  "users#login"
  post '/signup', to:  "users#signup"
end
