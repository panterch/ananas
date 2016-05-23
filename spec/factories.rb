FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "email_#{n}@example.com" }
    password 'welcome'
    password_confirmation 'welcome'
  end

  factory :mentor do
    job_title 'A mentor'
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

end
