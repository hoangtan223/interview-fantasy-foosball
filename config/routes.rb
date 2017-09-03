Rails.application.routes.draw do
  get 'games/create'

  root 'home#index'

  resources :users
  get 'players' => 'users#index'
  get 'sign_up' => 'users#new'
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  get 'sign_out' => 'sessions#destroy'

  resources :teams
  get 'my_teams' => 'teams#my_teams'

  resources :team_members, only: [:create]
  get 'invite_user/:id' => 'team_members#new', as: 'invite_user'
  get 'invitations' => 'team_members#invitations'
  get 'update_invitation' => 'team_members#update', as: 'update_invitation'

  resources :matches
  get 'start_match/:id' => 'matches#start_match', as: 'start_match'

  resources :games
end
