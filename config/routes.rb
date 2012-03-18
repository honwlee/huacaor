Huacaor::Application.routes.draw do
  get "sessions/new"

  get 'register' => 'users#new', :as => 'register'
  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'

  resources :sessions, :only => [:new, :create, :destroy]

  resources :users

  resources :genus

  resources :families

  resources :tags

  resources :users

  resources :pictures

  resources :plants do
    resources :comments
  end

  get '/settings/password'
  post '/settings/update_password'
  get '/settings/profile'
  put '/settings/update_profile'
  post '/settings/reset_pwd'

  root :to => 'home#index'
 
  match "/about" => "home#about"
  match "/forgot_pwd" => "settings#forget_pwd"
  match "/images/uploads/*path" => "gridfs#serve"

  root :to => 'home#index'

end
