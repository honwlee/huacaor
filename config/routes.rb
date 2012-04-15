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

  resource :settings do #登录／登出 个人头像
    get :password
    put :update_password
    get :profile
    put :update_profile
    get :avatar
    post :upload_avatar
    put :update_avatar
    get :forget_pwd
    post :reset_pwd
  end

  resource :upload do #上传
    get :fetch_photo
    post :avatar
    post :photo
  end

  namespace :admin do
    resources :users
    resources :tags
    resources :plants do
      resources :pictures
    end

    resources :plant_base_info 
  end

  root :to => 'home#index'
 
  match "/about" => "home#about"
  match "/forgot_pwd" => "settings#forget_pwd"
  match "/images/uploads/*path" => "gridfs#serve"
  match ":user_name" => "users#show"
end
