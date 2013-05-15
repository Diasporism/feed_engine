FeedEngine::Application.routes.draw do
  root to: 'platform#index'

  get '/auth/google_oauth2/callback', as: "session_new", to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')

  get '/signout', to: 'sessions#destroy', as: 'signout'
  get '/platform/splash', to: 'platform#splash', as: 'splash'

  resources :providers, only: [:destroy, :create]
end
