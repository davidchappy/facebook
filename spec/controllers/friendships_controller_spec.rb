require "rails_helper"

RSpec.describe FriendshipsController, :type => :controller do
  include Devise::Test::ControllerHelpers
  
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, email: "sample@example.com") }
  let!(:user3) { create(:user, email: "somebody@example.com") }
  let!(:friendship) { Friendship.create(user_id: user.id, friend_id: user3.id) }

  before do
    sign_in user
    Friendship.create(user_id: user.id, friend_id: user2.id)
  end

  it "requires a logged_in user for creating" do
    sign_out user
    post :create, params: { friend_id: user2.id }
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "requires a logged_in user for creating" do
    sign_out user
    patch :update, params: { id: friendship.id }
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "requires a logged_in user for destroying" do
    sign_out user
    delete :destroy, params: { id: friendship.id }, method: :delete
    expect(subject).to redirect_to(new_user_session_url)
  end

  # Friending to be tested in integration tests

end