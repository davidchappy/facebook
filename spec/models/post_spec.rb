require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }

  it "is valid" do
    expect(post).to be_valid
  end

  it "requires a user_id" do
    post.user_id = nil
    expect(post).to be_invalid
  end

  it "requires content" do
    post.content = ""
    expect(post).to be_invalid
  end

  it "requires a minimum of 6 characters" do
    post.content = "a" * 5
    expect(post).to be_invalid
  end

  it "limits content to 5000 characters" do
    post.content = "a" * 5001
    expect(post).to be_invalid
  end

  it "orders posts by most recent first" do
    Post.create(user_id: user.id, content: "Sample content")
    Post.create(user_id: user.id, content: "More sample content", created_at: 50.days.ago)
    latest = Post.order("created_at").last
    expect(latest).to eq(Post.last)
  end

  it "destroys associated comments" do
    post.comments.create(user_id: user.id, content: "Sample comment")
    expect{post.destroy}.to change{Comment.count}.by(-1)
  end

  it "destroys associated likes" do
    user.likes.create(post_id: post.id)
    expect{post.destroy}.to change{Like.count}.by(-1)
  end

end
