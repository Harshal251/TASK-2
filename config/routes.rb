# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  #  root "home#home"
  get '/member-data', to: 'members#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users
  resources :slots
  resources :floors
  # Defines the root path route ("/")
  # root "articles#index"
  get '*path', to: 'application#routing_error'
  post '*path', to: 'application#routing_error'
end
