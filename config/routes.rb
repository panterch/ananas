Rails.application.routes.draw do
  resources :members
  resources :teams
  resources :mentors
  resources :events

  devise_for :users

  root to: "users#index"
end
