Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'top#index'

  resources :address, only: [:show, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update, :destroy]

  resources :items do
    collection do # 新規用（new) usr:products/newのため
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
    end
    member do # 編集(edit用) usl: products/id/editのため
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
    end
  end
end
