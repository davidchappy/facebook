require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FriendshipsHelper. For example:
#
# describe FriendshipsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe FriendshipsHelper, type: :helper do

  let(:user) { create(:user) }
  let(:user2) { create(:user, email: "sample@example.com") }

  describe "friendship_exists" do
    it "returns false if a friendship with the target user doesn't exist" do
      expect(friendship_exists?(user2, user)).to be false
    end

    it "returns true if a friendship with the target user doesn't exist" do
      user.friendships.create(friend_id: user2.id)
      expect(friendship_exists?(user2, user)).to be true
    end
  end

end
