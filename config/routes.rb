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

  resources :items, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do # 新規用（new) usr:items/newのため
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'category_size', defaults: { format: 'json' }
    end
    member do # 編集(edit用) usl: items/id/editのため
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'category_size', defaults: { format: 'json' }
    end
    resources :categories, only: [:show]
  end

  resources :coordinates do
    collection do
      get 'history', to: 'coordinates#history'
    end
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy] do
      collection do
        get 'index', to: 'bookmarks#index'
      end
    end
  end
end
