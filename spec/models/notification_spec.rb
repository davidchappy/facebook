require 'rails_helper'

RSpec.describe Notification, type: :model do

  let(:user) { create(:user) }
  let(:notification) { create(:notification, user_id: user.id) }

  it "is valid" do
    expect(notification).to be_valid
  end

  it "requires a user_id" do
    notification.user_id = nil 
    expect(notification).to be_invalid
  end

  it "requires content" do
    notification.content = "   "
    expect(notification).to be_invalid
  end

end
