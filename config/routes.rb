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
end
