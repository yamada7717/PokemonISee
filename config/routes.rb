Rails.application.routes.draw do
  get 'follows/create'
  get 'follows/destroy'
  root 'tops#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'
  get '/users', to: redirect('/users/new')
  resources :users, only: %i[new create show edit update destroy] do
    member do
      get :mypage
      get :private_builds
      get :public_double_builds
      get :private_double_builds
      get :single_battle_likes
      get :double_battle_likes
      get :following
      get :followers
    end
    resource :follow, only: %i[create destroy]
  end
  resources :builds do
    collection do
      get :double_battles
    end
    resources :pokemon_parties, only: %i[new edit create destroy]
    resource :like, only: [:create, :destroy]
  end
end
