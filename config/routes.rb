Rails.application.routes.draw do

  resources :users, only: [:edit, :update, :destroy]
  resources :analysis, only: [:index, :create]
  resources :messages, only: :index

  #################
  # Devise routes #
  #################
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }

  authenticated :user do
    root to: "analysis#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#index", as: :unauthenticated_root
  end
end
