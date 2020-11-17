Rails.application.routes.draw do
  devise_for :users
  get 'dashboard', to: 'pages#dashboard'
  root to: 'pages#home'
  resources :users, only: [:edit, :update] do
    resources :coders, only: [:new, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :coders, only: [:index, :show, :edit, :update] do
    resources :missions, only: [:new, :create]

  end
  resources :missions, only: [:index, :edit, :update]
end
