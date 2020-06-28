Rails.application.routes.draw do
  root 'home#index'
  get '/oauth2/google/auth', to: 'google_oauth#auth'
  get '/oauth2/google/callback', to: 'google_oauth#callback'

  get '/fitbit/authenticate', to: 'fitbit/authenticate#authenticate'
  get '/fitbit/callback', to: 'fitbit/authenticate#callback'
  get '/fitbit/webhook', to: 'fitbit/webhook#verify'
  post '/fitbit/webhook', to: 'fitbit/webhook#notification'

  get '/health_planet/authenticate', to: 'health_planet/authenticate#authenticate'
  get '/health_planet/callback', to: 'health_planet/authenticate#callback'

  get '/logout', to: 'sessions#destroy'

  require 'auth_constraint'
  constraints lambda {|request| AuthConstraint.admin?(request) } do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  get '*path', to: 'home#index', constraints: lambda {|req| req.format == :html}

  # API
  get '/sessions', to: 'sessions#show'
  get '/dashboard', to: 'dashboard#index'

  resource :users, only: [:show, :update] do
    get 'saved', on: :collection
  end
  resources :diaries, param: :date, only: [:index, :show, :create, :update, :destroy]
  resources :user_defined_items
  resource :nature_remo, only: [:create]
  resources :chinese_medicine_constitutions, only: [:index]
  resources :chinese_medicine_selections, only: [:index]
  resources :chinese_medicine_diagnoses, only: [:index, :create]

  namespace :fitbit do
    get '/', to: 'authenticate#show'
    post '/subscription', to: 'authenticate#subscribe'
    resources :sleeps, only: [:index, :show] do
      get 'sync', on: :collection
    end
    resources :activities, only: [:index, :show] do
      get 'sync', on: :collection
    end
    resources :heart_rates, only: [:index, :show] do
      get 'sync', on: :collection
    end
  end

  namespace :health_planet do
    get '/authenticate', to: 'authenticate#authenticate'
    get '/callback', to: 'authenticate#callback'
    get '/', to: 'authenticate#show'

    resources :innerscans, only: [:index, :show] do
      get 'sync', on: :collection
    end
  end

  namespace :admin do
    resources :chinese_medicine_selections, only: [:index, :create, :update]
  end
end
