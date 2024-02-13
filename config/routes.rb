Rails.application.routes.draw do
  root 'tops#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create show edit update destroy]
end
