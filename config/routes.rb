Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :alerts do
    resources :tweets, only: [ :index ] do
      collection do
        get :update_tweets
      end
    end
  end
  resources :tweets, only: [ :destroy ]
end
