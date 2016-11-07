Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {    sign_in: 'login', 
                                                sign_out: 'logout', 
                                                password: 'password_reset', 
                                                confirmation: 'verification' }
  root to: "posts#index"
  resources :posts
end
