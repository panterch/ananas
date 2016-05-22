FactoryGirl.define do  

  factory :user do
    sequence(:email) { |n| "email_#{n}@example.com" }
    password 'welcome'
    password_confirmation 'welcome'
  end

end
