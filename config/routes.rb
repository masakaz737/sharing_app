Rails.application.routes.draw do

  root 'items#index'

  devise_for :users
  namespace :member do
    resources :users, only: %i[show edit update]
    resources :items, shallow: true do
      resources :deals
    end
  end
  resources :items, only: %i[index show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
