Rails.application.routes.draw do

  # Application routes
  resources :users, only: [:edit, :update]

  get '/setup', to: 'users#setup'
  resources :analysis, only: [:index, :create]
  resources :messages, only: :index
  resources :friends, only: [:index]

  get '/write_on_wall', to: 'friends#write_on_wall'

  # Graphical routes
  get '/sports-overview', to: 'analysis#current_user_sports_graphic'
  get '/smokes-overview', to: 'analysis#current_user_smokes_graphic'

  # Messages routes
  get '/messages/count', to: 'messages#count'

  # Devise routes
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :users, controllers: { sessions: "users/sessions" }
  
  authenticated :user do
    root to: "analysis#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#index", as: :unauthenticated_root
  end
end
