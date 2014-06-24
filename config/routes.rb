Rails.application.routes.draw do

  # Application routes
  resources :users, only: [:edit, :update]
  get '/setup', to: 'users#setup'
  resources :analysis, only: [:index, :create]
  resources :messages, only: :index
  resources :friends, only: [:index]

  get '/write_on_wall', to: 'friends#write_on_wall'

  # Devise routes
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }

  authenticated :user do
    root to: "analysis#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#index", as: :unauthenticated_root
  end
end
