Rails.application.routes.draw do

  # Application routes
  resources :users, only: [:edit, :update]

  get '/setup', to: 'users#setup'
  resources :analysis, only: [:index, :create]
  resources :messages, only: :index
  resources :friends, only: [:index]

  get '/write_on_wall', to: 'friends#write_on_wall'

  # Search for smokes / sports
  get '/find-smokes', to: 'analysis#find_smoke_for_date'
  get '/find-sport' , to: 'analysis#find_sport_for_date'

  # Graphical routes
  get '/sports-overview', to: 'analysis#current_user_sports_graphic'
  get '/smokes-overview', to: 'analysis#current_user_smokes_graphic'

  # Messages routes
  get '/messages/count', to: 'messages#count'

  # Devise routes
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }

  authenticated :user do
    root to: "analysis#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#index", as: :unauthenticated_root
  end
end
