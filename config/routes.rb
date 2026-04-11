Rails.application.routes.draw do
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help", as: :help
  get "/about", to: "static_pages#about", as: :about
  get "/contact", to: "static_pages#contact", as: :contact
  get "/signup", to: "users#new", as: :signup
  get "/signin", to: "sessions#new"
  get "/rooms", to: "static_pages#home"
  post "/signin", to: "sessions#create"
  delete "/signout", to: "sessions#destroy"
  resources :users, param: :slug
  resources :account_activations, only: %i[ edit ]
  resources :password_resets, only: %i[ new create edit update ]
  resources :rooms, only: %i[ new create show destroy ], param: :slug
  root "static_pages#home"
end
