FeedEngine::Application.routes.draw do
  root to: 'platform#index'

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/signout', to: 'sessions#destroy', as: 'signout'
  get '/platform/splash', to: 'platform#splash', as: 'splash'
end
