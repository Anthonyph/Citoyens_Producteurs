Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :stores do
    resources :store_product
  end
  resources :comments #, only: [:create, :update, :destroy]

  resources :product
  resources :events do
    resources :appointments
  end
  resources :users, only: [:show]
end