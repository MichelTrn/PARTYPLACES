Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  resources :places
  resources :bookings, only: [:update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
end
