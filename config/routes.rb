Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root 'tops#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post 'guest_login', to: 'user_sessions#guest_login'
  delete 'logout', to: 'user_sessions#destroy'
  get '/users', to: redirect('/users/new')
  get 'follows/create'
  get 'follows/destroy'
  resources :password_resets, only: %i[new create edit update]
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
  get '/404', to: 'errors#not_found', as: :not_found
  get '/500', to: 'errors#internal_server_error', as: :internal_server_error
  match '*path', to: 'errors#not_found', via: :all
end
