FeedEngine::Application.routes.draw do
  root to: 'platform#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create', as: 'session_new'
  get '/auth/:provider/callback', to: 'providers#create'
  match 'auth/failure', to: redirect('/')

  get '/signout', to: 'sessions#destroy', as: 'signout'
  get '/platform/splash', to: 'platform#splash', as: 'splash'

  resources :providers, only: [:destroy, :create]
  get '/new_provider', to: 'providers#create', as: 'add_provider'
  mount Resque::Server, :at => '/resque'
end
