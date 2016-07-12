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
    resources :team_members do
      collection do
        get :new_form
      end
    end
    resources :team_mentors do
      collection do
        get :new_form
      end
    end
    resources :members
    resources :ratings, only: [:index]
    resources :mentorings
  end
  resources :mentors do
    resources :team_mentors
    resources :teams
    resources :ratings, except: :new
    resources :dashboard, only: :index
    resources :expert_sessions do
      member do
        post :book
      end
    end
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

  resources :expert_sessions do
    member do
      post :accept
      post :reject
    end
    resources :attendances
  end

  resources :attendances do
    member do
      post :attend
      post :decline
    end
  end

  resources :ratings, except: :new

  controller :calendar, as: :calendar, path: 'calendar/:token' do
    get :events
  end

  root to: "events#timeline"
end
