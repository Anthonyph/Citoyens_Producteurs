Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :stores
  resources :comments #, only: [:create, :update, :destroy]
  resources :events do
    resources :appointments
  end
  resources :users, only: [:show]

  get 'story', to: 'home#story'
  get 'community', to: 'home#community'
end