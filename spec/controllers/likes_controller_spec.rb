require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  let!(:user) { create(:user) }
  let!(:user2) { build(:user, email: "sample@example.com", confirmed_at: Date.today) }
  let!(:new_post) { create(:post, user_id: user.id) }
  let!(:new_like) { Like.create(user_id: user.id, post_id: new_post.id) }

  it "redirects create when not logged in" do
    expect do 
      post :create, params: { like: { user_id: user.id, 
                                      post_id: new_post.id } }
    end.not_to change{Like.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "creates a like when logged in" do
    expect(Like.count).to eq(1)
    sign_in user 
    post :create, params: { like: { user_id: user.id, 
                                    post_id: new_post.id } }
    expect(Like.count).to eq(2)
    expect(subject).to redirect_to(post_url(new_post))
  end

  it "redirects destroy when not logged in" do
    expect do 
      delete :destroy, params: { id: new_like.id }
    end.not_to change{Like.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "redirects destroy for wrong likes" do
    sign_in user2
    expect do 
      delete :destroy, params: { id: new_like.id }
    end.not_to change{Like.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "destroys a like when successful" do
    sign_in user
    expect do 
      delete :destroy, params: { id: new_like.id }
    end.to change{Like.count}.by(-1)
  end

end
