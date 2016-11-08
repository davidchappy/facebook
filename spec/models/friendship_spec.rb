require 'rails_helper'

RSpec.describe Friendship, type: :model do

  let(:user) { create(:user) }
  let(:user2) { create(:user, email: "sample@example.com") }
  let(:friendship) { Friendship.create(user_id: user.id, friend_id: user2.id) }

  it "is valid" do
    expect(friendship).to be_valid
  end

  it "is pending when created" do
    expect(friendship.status).to eq("pending")
  end

  it "requires a user_id" do
    friendship.user_id = nil 
    expect(friendship).to be_invalid
  end

  it "requires a friend_id" do
    friendship.friend_id = nil
    expect(friendship).to be_invalid
  end

  it "doesn't allow someone to friend themselves" do
    friendship.friend_id = user.id
    expect(friendship).to be_invalid
  end

end