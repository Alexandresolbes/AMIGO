Rails.application.routes.draw do
  mount RailsAdmin::Engine => '//admin', as: 'rails_admin'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :trips do
    get "/random-wheel", to: "pages#random_wheel"
    get "/invite", to: "pages#invite"
    post "/invite", to: "pages#send_invite"
    get "/notifications", to: "pages#notifications"
    get "/board", to: "trips#board"
    resources :user_trips, only: [:create, :destroy]
    resources :activities, only: [:index, :new, :create] do
      resources :participations, only: [:create, :destroy]
    end

    resources :activities, only: [:show, :destroy, :edit, :update]

    resources :rooms, only: [:index, :show] do
      resources :messages, only: :create
    end
    resources :wallets, only: [:show, :create, :update] do
      resources :bills, only: [:index, :create, :update, :destroy]
    end
  end
end
