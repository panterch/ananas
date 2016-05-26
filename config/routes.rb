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
    resources :ratings, only: [:index]
  end
  resources :mentors do
    resources :team_mentors
    resources :teams
    resources :ratings, except: :new
  end

  resources :events do
    resources :attendances do
      member do
        post :attend
        post :decline
      end
    end
    collection do
      get :timeline
    end
  end
  resources :mentorings do
    resources :attendances do
      member do
        post :attend
        post :decline
      end
    end
    collection do
      get :timeline
    end
  end

  resources :attendances do
    member do
      post :attend
      post :decline
    end
  end

  resources :ratings, except: :new
  resources :mentorings

  root to: "events#timeline"
end
