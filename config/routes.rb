Rails.application.routes.draw do
  resources :members
  resources :teams do
    resources :team_members
  end
  resources :team_members
  resources :mentors
  resources :events

  devise_for :users

  root to: "events#index"
end
