Rails.application.routes.draw do

  # Userログイン時
  authenticated :user do
    root 'member/items#index'
  end

  # User非ログイン時
  root 'items#index'

  devise_for :users
  namespace :member do
    resources :users, only: %i[show edit update]
    resources :items
  end
  resources :items, only: %i[index show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
