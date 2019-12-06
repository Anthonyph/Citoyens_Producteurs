Rails.application.routes.draw do
  root 'home#index'
  namespace :admin do
    resources :users  
    root 'admin#index'
  end
  
  devise_for :users
  resources :stores
  resources :comments #, only: [:create, :update, :destroy]

  resources :product
  resources :events do
    resources :appointments
  end
  resources :users, only: [:show]
end