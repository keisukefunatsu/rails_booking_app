Rails.application.routes.draw do
  resources :groups
  resources :members_roles
  resources :reservations
  resources :members
  resources :spaces
  root :to => 'home#index'
  resources :roles
  resources :users
  post 'authenticate' => 'authenticate#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
