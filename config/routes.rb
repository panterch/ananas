Rails.application.routes.draw do
  resources :team_mentors
  resources :team_members

  resources :members do
    resources :team_members
  end
  resources :teams do
    resources :team_members
    resources :team_mentors
  end
  resources :mentors do
    resources :team_mentors
  end

  resources :events

  devise_for :users

  root to: "events#index"
end
