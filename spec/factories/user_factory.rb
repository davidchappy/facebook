FactoryGirl.define do
  factory :user do
    name "Example User"
    email "user@example.com"
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
  end
end