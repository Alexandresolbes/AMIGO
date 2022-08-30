Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :trips do
    resources :user_trips, only: [:create, :destroy]
    resources :activities, only: [:index, :new, :create] do
      resources :participations, only: [:create, :destroy]
    end

    resources :activities, only: [:show, :destroy, :edit, :update]

    resources :rooms, only: :show do
      resources :messages, only: :create
    end
  end
end
