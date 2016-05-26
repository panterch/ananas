FactoryGirl.define do
  factory :attendance do
    event nil
    state "invited"
    guest nil
  end

  factory :user do
    sequence(:email) { |n| "email_#{n}@example.com" }
    password 'welcome'
    password_confirmation 'welcome'
    association :profile, factory: :mentor
  end

  factory :mentor do
    job_title 'A mentor'
  end

  factory :member do
    description 'A member'
  end

  factory :team do
    name 'A team'
  end

  factory :mentoring do
    summary 'A mentoring'
    start_at Date.parse('2015-11-13 13:00')
    end_at Date.parse('2015-11-13 14:00')
    association :team
    association :mentor
  end

  factory :event do
    summary 'An event'
    start_at Date.parse('2015-11-13 13:00')
    end_at Date.parse('2015-11-13 14:00')
  end

  factory :rating do
    association :team
    association :event
    association :mentor

    votes { { team_vote: '5', business_idea_vote: '1', progress_vote: '3' } }
  end
end
