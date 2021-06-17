# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :sessions

  root to: 'home#index'

  sp_rails_saml_routes
end
