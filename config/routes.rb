Rails.application.routes.draw do
  post 'friendships/create', to: 'friendships#create', as: 'friendships'
  get 'friendships/update'
  get 'friendships/destroy'

  devise_for :users, path: '', path_names: {    sign_in: 'login', 
                                                sign_out: 'logout', 
                                                password: 'password_reset', 
                                                confirmation: 'verification' }
  root to: "posts#index"
  resources :posts
  resources :users, only: [:show, :index]
end
