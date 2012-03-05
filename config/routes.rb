Huacaor::Application.routes.draw do
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
 
  match "/login" => "home#login"
  match "/about" => "home#about"
  match "/register" => "home#register"
  match "/forgot_pwd" => "home#forgot_pwd"
  match "/images/uploads/*path" => "gridfs#serve"

  # 临时
  # match "/plant" => "plants#show"
  # match "/plant/edit" => "plants#edit"

end
