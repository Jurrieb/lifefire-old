Rails.application.routes.draw do

  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:edit, :update, :destroy]
  resources :analysis, only: [:index, :create]

  #################
  # Devise routes #
  ############################################
  authenticated :user do
    root to: "analysis#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#index", as: :unauthenticated_root
  end
end
