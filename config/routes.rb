FeedEngine::Application.routes.draw do
  root to: 'platform#index'
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: 'signout'
  get '/platform/splash', to: 'platform#splash', as: 'splash'
end
