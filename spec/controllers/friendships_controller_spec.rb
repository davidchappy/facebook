require "rails_helper"

RSpec.describe FriendshipsController, :type => :controller do
  include Devise::Test::ControllerHelpers
  
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, email: "sample@example.com", confirmed_at: Date.today) }
  let!(:user3) { create(:user, email: "somebody@example.com", confirmed_at: Date.today) }
  let!(:friendship) { Friendship.create(user_id: user.id, friend_id: user3.id) }

  it "requires a logged_in user for creating" do
    sign_out user
    post :create, params: { friend_id: user2.id }
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "doesn't allow friending someone who's already a friend" do
    Friendship.create(user_id: user.id, friend_id: user2.id)
    sign_in user2
    expect do
      post :create, params: { friend_id: user.id, user_id: user2.id }
    end.to_not change{Friendship.count}
    expect(subject).to redirect_to(user_path(user))
  end

  it "requires a logged_in user for updating" do
    sign_out user
    patch :update, params: { id: friendship.id }
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "requires a logged_in user for destroying" do
    sign_out user
    delete :destroy, params: { id: friendship.id }, method: :delete
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "gets index" do
    sign_in user
    get :index
    expect(response.status).to eq(200)
  end

end