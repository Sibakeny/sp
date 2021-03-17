# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/saml/sso', to: 'saml#consume'
  get '/saml/metadata', to: 'saml#metadata'

  resource :saml_settings
  resource :sessions

  root to: 'home#index'
end
