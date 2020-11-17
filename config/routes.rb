Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  get 'about', to: 'pages#about'
  resources :users, only: [:edit, :update] do
    resources :coders, only: [:new, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :coders, only: [:index, :show, :edit, :update] do
    resources :missions, only: [:new, :create]

  end
  resources :missions, only: [:index, :edit, :update]
end
