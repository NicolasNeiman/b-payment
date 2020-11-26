Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :transactions, only: [:index]
  get 'profile', to: 'pages#profile'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :users do
        resources :sessions, only: [:create]
      end
    end
  end
end
