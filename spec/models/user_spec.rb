require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.new(  name:                  "Example User",
                            email:                 "user@example.com",
                            password:              "password",
                            password_confirmation: "password") }
  let(:user2) { User.new(  name:                  "Sample User",
                            email:                 "sample@example.com",
                            password:              "password",
                            password_confirmation: "password") }
  
  it "is valid" do
    expect(user).to be_valid
  end

  it "has a name" do
    user.name = "   "
    expect(user).to be_invalid
  end

  it "has a name that isn't too short or too long" do
    user.name = "dac"
    expect(user).to be_invalid
    user.name = "a" * 121
    expect(user).to be_invalid
  end

  it "has an email" do
    user.email = "  "
    expect(user).to be_invalid
  end

  it "has an email that isn't too long" do
    user.email = ("a" * 244) + "@example.com"
    expect(user).to be_invalid
  end

  it "has an email that is in the correct format" do
    user.email = "incorrect"
    expect(user).to be_invalid
    user.email = "correct@example.com"
    expect(user).to be_valid
  end

  it "has a unique email address" do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).to be_invalid
  end

  it "saves emails as lowercase" do
    # Hartl Tutorial
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    expect(user.reload.email).to eq(mixed_case_email.downcase)
  end

  it "has a password" do
    user.password = "  "
    expect(user).to be_invalid
  end

  it "has a password that isn't too long or too short" do
    user.password = "passw"
    user.password_confirmation = "passw"
    expect(user).to be_invalid
    user.password = "a" * 129
    user.password_confirmation = "a" * 129
    expect(user).to be_invalid
    user.password = "password"
    user.password_confirmation = "password"
    expect(user).to be_valid
  end

  it "requires a matching password confirmation" do
    user.password = "password123"
    expect(user).to be_invalid
  end

  it "destroys associated posts" do
    user.save
    user.posts.create(content: "New post")
    expect{user.destroy}.to change{Post.count}.by(-1)
  end


end
