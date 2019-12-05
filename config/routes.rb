Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :stores
  resources :comments #, only: [:create, :update, :destroy]
  resources :events do
    resources :appointments
  end
end