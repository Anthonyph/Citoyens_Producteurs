Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :stores
  resources :comments #, only: [:create, :update, :destroy]

  resources :product
  resources :events do
    resources :product_events
    resources :appointments do
      resources :product_appointments
      end
  end
end