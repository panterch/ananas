Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :team_mentors
  resources :team_members

  resources :members do
    resources :team_members
    resources :teams
  end
  resources :teams do
    resources :team_members
    resources :team_mentors
    resources :members
  end
  resources :mentors do
    resources :team_mentors
    resources :teams
  end

  resources :events
  resources :mentorings

  root to: "events#index"
end
