require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let!(:user) { create(:user) }
  let!(:user2) { build(:user, email: "sample@example.com", confirmed_at: Date.today) }
  let!(:new_post) { create(:post, user_id: user.id) }
  let!(:new_comment) { create(:comment, post_id: new_post.id, user_id: user.id) }

  it "redirects create when not logged in" do
    expect do 
      post :create, params: { comment: { content: "Lorem ipsum", 
                                          user_id: user.id, 
                                          post_id: new_post.id } }
    end.not_to change{Comment.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "creates a comment when logged in" do
    expect(Comment.count).to eq(1)
    sign_in user 
    post :create, params: { comment: {  content: "Lorem ipsum", 
                                        user_id: user.id, 
                                        post_id: new_post.id } }
    expect(Comment.count).to eq(2)
    expect(subject).to redirect_to(post_url(new_post))
  end

  it "redirects update when not logged in" do
    expect do 
      patch :update, params: { id: new_comment.id, comment: { content: "New Comment", 
                                                              user_id: user.id, 
                                                              post_id: new_post.id} } 
    end.not_to change{Comment.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "redirects update for wrong posts" do
    sign_in user2
    expect do 
      patch :update, params: { id: new_comment.id, comment: { content: "New Comment", 
                                                              user_id: user.id, 
                                                              post_id: new_post.id} } 
    end.not_to change{Comment.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "changes the post's content when update is successful" do
    sign_in user
    expect do 
      patch :update, params: { id: new_comment.id, comment: { content: "New Comment", 
                                                              user_id: user.id, 
                                                              post_id: new_post.id} } 
    end.to change{new_comment.reload.content}
  end

  it "redirects destroy when not logged in" do
    expect do 
      delete :destroy, params: { id: new_comment.id }
    end.not_to change{Comment.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "redirects destroy for wrong posts" do
    sign_in user2
    expect do 
      delete :destroy, params: { id: new_comment.id }
    end.not_to change{Comment.count}
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "destroys a post when successful" do
    sign_in user
    expect do 
      delete :destroy, params: { id: new_comment.id }
    end.to change{Comment.count}.by(-1)
  end

end
