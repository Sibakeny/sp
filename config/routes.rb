# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/saml/consume/:id', to: 'saml#consume', as: :saml_consume
  get '/saml/metadata/:id', to: 'saml#metadata', as: :saml_metadata
  post '/saml/sso', to: 'saml#sso', as: :saml_sso
  get '/saml/login', to: 'saml#login', as: :saml_login

  resource :saml_settings
  resource :sessions

  root to: 'home#index'
end
