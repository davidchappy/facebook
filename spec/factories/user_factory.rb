FactoryGirl.define do
  factory :user do
    name "Example User"
    email "user@example.com"
    password "password"
    password_confirmation "password"
  end

  factory :user2 do
    name "Sample User"
    email "sample@example.com"
    password "password"
    password_confirmation "password"
  end
end