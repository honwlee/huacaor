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

  root :to => 'home#index'
 
  #match "/login" => "home#login"
  match "/about" => "home#about"
  #match "/register" => "home#register"
  match "/forgot_pwd" => "home#forgot_pwd"

  # 临时
  # match "/plant" => "plants#show"
  # match "/plant/edit" => "plants#edit"

end
