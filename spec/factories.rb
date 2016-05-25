FactoryGirl.define do
  factory :attendance do
    event nil
    state "MyString"
    host nil
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
end
