# config/routes.rb
Rails.application.routes.draw do
  resources :manufactures
  resources :models
  resources :body_types
  resources :bodies
  resources :trunks
  resources :trunk_types
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
