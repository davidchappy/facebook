require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:user) { create(:user) }
  let(:user2) { create(:user, email: "sample@example.com") }
  let(:post) { create(:post, user_id: user.id) }
  let(:like) { Like.create(user_id: user.id, post_id: post.id) }

  it "is valid" do
    expect(like).to be_valid
  end

  it "requires a user_id" do
    like.user_id = nil 
    expect(like).to be_invalid
  end

  it "requires a post_id" do
    like.post_id = nil 
    expect(like).to be_invalid
  end

  it "increases the number of likes for the post" do
    expect{user2.likes.create(post_id: post.id)}.to change{Like.count}.by(1)
  end

end
