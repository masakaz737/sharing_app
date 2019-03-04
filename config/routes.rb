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

      member do
        patch :approve
      end
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
