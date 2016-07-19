Rails.application.routes.draw do
  resources :questions
  resources :surveys
  resources :sessions, only: [:new, :create]
  resources :users
  root 'surveys#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
