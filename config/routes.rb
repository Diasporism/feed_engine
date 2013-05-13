FeedEngine::Application.routes.draw do
  root to: 'platform#index'

  match '/auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match '/signout', to: 'sessions#destroy', as: 'signout'
end
