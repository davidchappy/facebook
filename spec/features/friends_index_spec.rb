require "rails_helper"

RSpec.feature "Friends index", :type => :feature do

  let!(:user) { create(:user) }
  let!(:user2) { create(:user,  name: "New User", 
                                email: "new@sample.com", 
                                confirmed_at: Date.today) }
  let!(:user3) { create(:user,  name: "Another User", 
                                email: "another@sample.com", 
                                confirmed_at: Date.today) }
  let!(:friendship) { Friendship.create(user_id: user.id, friend_id: user2.id) }
  let!(:friendship2) { Friendship.create(user_id: user.id, 
                                        friend_id: user3.id, 
                                        status: 'friends') }

  scenario "Friends index view" do
    login_as(user)
    visit friends_url

    expect(page).to have_text('Your Friends', count: 2)
    expect(page).to have_selector('li.friend_listing', count: user.friends.length)

    expect(page).to have_text(user2.name, count: 1)
    expect(page).to have_text('pending')

    expect(page).to have_text(user3.name, count: 1)
    expect(page).to have_selector('a', text: 'unfriend')
  end

end