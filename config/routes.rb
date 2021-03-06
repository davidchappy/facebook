Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'

  devise_for :users, path: '',  path_names: {   sign_in: 'login', 
                                                sign_out: 'logout', 
                                                password: 'password_reset', 
                                                confirmation: 'verification' },
                                controllers: {  omniauth_callbacks: "users/omniauth_callbacks",
                                                registrations: "registrations",
                                                sessions: "sessions" }
  root to: "posts#index"
  resources :posts
  resources :comments, only: [:create, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :users, only: [:show, :index]
  resources :friendships, only: [:create, :update, :destroy, :index]
  get 'friends', to: 'friendships#index'
end
