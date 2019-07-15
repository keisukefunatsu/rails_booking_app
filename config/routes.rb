Rails.application.routes.draw do
  # post 'register/index'
  post 'register' => 'register#index'
  get 'register/activate_account' => 'register#activate_account' 
  resources :member_roles
  resources :groups do
    resources :members
    resources :spaces
  end
  resources :spaces do
    resources :reservations
  end
  root :to => 'home#index'
  resources :roles
  resources :users
  post 'authenticate' => 'authenticate#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
