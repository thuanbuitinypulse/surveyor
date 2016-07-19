Rails.application.routes.draw do
  resources :surveys
  resources :sessions, only: [:new, :create]
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
