Rails.application.routes.draw do

  root 'items#index'

  devise_for :users
  resources :items, only: %i[index show]
  resources :categories

  namespace :member do
    resources :users, only: %i[show edit update]
    resources :items, shallow: true do
      resources :deals, only: %i[new create]
    end

    resources :deals do
      collection do
        delete :destroys
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
