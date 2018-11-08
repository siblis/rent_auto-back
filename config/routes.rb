# frozen_string_literal: true

Rails.application.routes.draw do
  resources :localities
  resources :statuses
  resources :cities
  resources :regions
  resources :states
  resources :countries
  resources :manufacturers
  resources :brands
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
