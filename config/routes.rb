# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :articles
    end
  end
end
