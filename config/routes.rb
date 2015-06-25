Rails.application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', as: :signin
  get '/signout' => 'sessions#destroy', as: :signout
  get '/auth/failure' => 'sessions#failure'

  if Rails.env.development?
    post '/debug/signin' => 'sessions#debug_signin', as: :debug_signin
  end

  resources :users, only: %i(show) do
    patch 'start_rally', on: :collection
    resources :stamps, only: %i(create destroy)
  end
  root 'home#index'
end
