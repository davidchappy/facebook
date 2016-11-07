FactoryGirl.define do
  factory :comment do
    content "A comment"
    user_id 1
    post_id 1
  end
end