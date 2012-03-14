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

  get '/settings/password' => 'settings#password'
  post '/settings/update_password' => 'settings#update_password'
  get '/settings/profile' => 'settings#profile'
  put '/settings/update_profile' => 'settings#update_profile'

  root :to => 'home#index'
 
  #match "/login" => "home#login"
  match "/about" => "home#about"
  #match "/register" => "home#register"
  match "/forgot_pwd" => "home#forgot_pwd"
  match "/images/uploads/*path" => "gridfs#serve"

  root :to => 'home#index'

end
