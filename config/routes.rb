Rails.application.routes.draw do
  root 'tops#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'
  get '/users', to: redirect('/users/new')
  resources :users, only: %i[new create show edit update destroy] do
    member do
      get :mypage
    end
  end
  resources :builds
end
