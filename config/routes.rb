Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'top#index'

  resources :users, only: [:show, :edit, :update]do
    member do
      get 'profile'
      patch 'profile_update'
    end
  end
end
