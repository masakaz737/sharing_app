Rails.application.routes.draw do

  root 'items#index'

  devise_for :users
  resources :items, only: %i[index show]
  resources :categories

  namespace :member do
    resources :users, only: %i[show edit update]
    resources :items
    resources :deals
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
