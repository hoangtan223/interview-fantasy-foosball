Rails.application.routes.draw do
  root 'home#index'

  resources :users
  get 'players' => 'users#index'
  get 'sign_up' => 'users#new'
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  get 'sign_out' => 'sessions#destroy'

  resources :teams
  get 'my_teams' => 'teams#my_teams'
end
