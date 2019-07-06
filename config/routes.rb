Rails.application.routes.draw do
  root :to => 'home#index'
  resources :roles
  resources :users
  post 'authenticate' => 'authenticate#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
