Rails.application.routes.draw do
  root 'home#index'
  namespace :admin do
    resources :users  
    root 'admin#index'
  end
  
  devise_for :users
  resources :stores do
    resources :store_product
  end
  resources :comments #, only: [:create, :update, :destroy]

  resources :product
  resources :events do
    resources :appointments
    resources :feedbacks
  end
  resources :users, only: [:show]

  get 'story', to: 'home#story'
  get 'community', to: 'home#community'
end