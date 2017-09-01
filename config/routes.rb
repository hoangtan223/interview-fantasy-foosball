Rails.application.routes.draw do
  root 'home#index'

  resources :users
  get 'sign_up' => 'users#new'
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  get 'sign_out' => 'sessions#destroy'
end
