Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :saml do
    post :sso, to: 'sso#consume'
    get :metadata, to: 'sso#metadata'
  end

  resources :sp_settings
  resource :sessions
end
