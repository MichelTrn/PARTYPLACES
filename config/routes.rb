Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  resources :places do
    resources :bookings, only: %i[new create]
  end
  resources :bookings, only: %i[update index] do
    member do
      patch '/accepted', to: "bookings#accepted"
      patch '/refused', to: "bookings#refused"

    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
end
