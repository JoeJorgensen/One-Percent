Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

namespace :api do
  
  resources :categories
    resources :post_categories
    resources :users
    resources :posts do
      resources :comments
      resources :likes
      resources :reposts
      end


  

   put 'users/update_image', to: 'users#update_image'
   get 'braintree_token', to: 'braintree#token'
   post 'payment', to: 'braintree#payment'
  end

   get '*other', to: 'static#index'
end


