Rails.application.routes.draw do
  get "profile/:id", to: "profiles#show", as: :profile
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
    unlocks: "users/unlocks"
  }
  resources :rooms do
    collection do
      post :search
    end
  end
  root "rooms#index"
end
