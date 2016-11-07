require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:comment) { create(:comment, user_id: user.id, post_id: post.id) }

  it "is valid" do
    expect(comment).to be_valid
  end

  it "requires a user_id" do
    comment.user_id = nil 
    expect(comment).to be_invalid
  end

  it "requires a post_id" do
    comment.post_id = nil 
    expect(comment).to be_invalid
  end

  it "limits its character count" do
    comment.content = "a" * 256
    expect(comment).to be_invalid
  end

end
