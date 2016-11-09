require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let!(:user) { create(:user) }
  let!(:user2) { build(:user, email: "sample@example.com", confirmed_at: Date.today) }
  let!(:new_post) { create(:post) }

  it "redirects create when not logged in" do
    expect do 
      post :create, params: { post: { content: "Lorem ipsum", user_id: user.id } }
    end.not_to change{Post.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "creates a post when logged in" do
    expect(Post.count).to eq(1)
    sign_in user 
    post :create, id: new_post.id, params: { post: { content: "Lorem ipsum", user_id: user.id } }
    expect(Post.count).to eq(2)
    expect(subject).to redirect_to(root_url)
  end

  it "redirects update when not logged in" do
    expect do 
      patch :update, params: { id: new_post.id, post: { content: "New Lorem", user_id: user.id } } 
    end.not_to change{Post.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "redirects update for wrong posts" do
    sign_in user2
    expect do 
      patch :update, params: { id: new_post.id, post: { content: "New Lorem", user_id: user.id } }
    end.not_to change{Post.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "changes the post's content when update is successful" do
    sign_in user
    expect do 
      patch :update, params: { id: new_post.id, post: { content: "Different content", user_id: user.id } }
    end.to change{new_post.reload.content}
  end

  it "redirects destroy when not logged in" do
    expect do 
      delete :destroy, params: { id: new_post.id }
    end.not_to change{Post.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "redirects destroy for wrong posts" do
    sign_in user2
    expect do 
      delete :destroy, params: { id: new_post.id }
    end.not_to change{Post.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "destroys a post when successful" do
    sign_in user
    expect do 
      delete :destroy, params: { id: new_post.id }
    end.to change{Post.count}
  end
  
end
