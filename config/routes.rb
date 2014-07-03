Rails.application.routes.draw do
  # Root for program
  root to: 'analysis#index'

  # First time user setup
  get '/setup', to: 'users#setup'

  # Facebook routes
  get '/write_on_wall', to: 'friends#write_on_wall'
  get '/profile', to: 'users#profile'

  # Search for smokes / sports
  get '/find-smokes', to: 'analysis#find_smoke_for_date'
  get '/find-sport' , to: 'analysis#find_sport_for_date'

  # Graphical routes
  get '/sports-overview', to: 'analysis#current_user_sports_graphic'
  get '/smokes-overview', to: 'analysis#current_user_smokes_graphic'

  # Messages routes
  get '/messages/count', to: 'messages#count'

  # Privacy policy
  get '/privacy_policy', to: 'pages#privacy_policy'

  # Devise for users
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                                    sessions: "users/sessions" }

  # Application routes
  resources :analysis, only: [:index, :create]
  resources :messages, only: :index
  resources :friends, only: [:index]
  resources :users, only: [:edit, :update, :destroy]

  # Pages (public)
  resources :pages, only: :index
  get '/users/:id', to: 'pages#users'
end
