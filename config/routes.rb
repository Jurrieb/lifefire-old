Rails.application.routes.draw do
  get 'activities/index'

  get 'activities/show'

  # Root for program
  root to: 'analysis#index'

  # First time user setup
  get '/setup', to: 'users#setup'

  # Facebook routes
  get '/write_on_wall', to: 'friends#write_on_wall'

  # Search for smokes / sports
  get '/find-smokes', to: 'smokes#find_smoke_for_date'
  get '/find-sport' , to: 'sports#find_sport_for_date'

  # Graphical routes
  get '/sports-overview', to: 'analysis#current_user_sports_graphic'
  get '/smokes-overview', to: 'analysis#current_user_smokes_graphic'

  # Privacy policy
  get '/privacy_policy', to: 'pages#privacy_policy'

  # Devise for users
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                                    sessions: "users/sessions" }
  # Application routes
  resources :analysis, only: [:index, :create]
  resources :messages, only: :index
  resources :friends, only: [:index, :create, :destroy] do
    resources :activities, only: :show do
      resources :comments, only: :create
    end
  end
  resources :smokes, only: [:new, :create]
  resources :sports
  resources :progress, only: :index

  get '/friends/search', to: 'friends#search', as: 'search'


  resources :users, only: [:edit, :update, :destroy]
  get '/users/:id', to: 'users#profile', as: 'profile'
  # Pages (public)
  resources :pages, only: :index

end
