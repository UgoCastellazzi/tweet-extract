Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :alerts do
    resources :leads, only: [ :index ] do
      collection do
        get :update_tweets
      end
    end
  end
  resources :leads, only: [ :destroy ]
end
