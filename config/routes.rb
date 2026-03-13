Rails.application.routes.draw do
  devise_for :users
  resources :rooms
  root "rooms#index"
end
