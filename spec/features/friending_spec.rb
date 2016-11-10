require "rails_helper"
require "rspec/expectations"

RSpec.feature "Friending", :type => :feature do

  let!(:user) { create(:user) }
  let!(:user2) { create(:user,  name: "New User", 
                                email: "new@sample.com", 
                                confirmed_at: Date.today) }
  let!(:post) { create(:post, user_id: user.id) }
  let!(:post2) { create(:post, user_id: user2.id, content: "This is user 2's post") }

  before(:each, accepting: true) do
    Friendship.create(user_id: user.id, friend_id: user2.id, status: 'pending')
  end

  scenario "Adding a friend" do
    login_as(user)
    visit root_url
    expect(Friendship.count).to eq(0)

    click_link('All Users')
    expect(current_url).to eq(users_url)
    expect(page).to have_text("All Users", count: 2)
    expect(page).to have_selector('a', text: user2.name)

    click_link(user2.name)
    expect(current_url).to eq(user_url(user2))
    expect(page).to have_text(user2.name)
    expect(page).to have_text('Not Friends.')
    expect(page).to have_selector('form.button_to')
    expect(page).to have_selector('input', class: "text-only")

    click_button('add friend')
    expect(current_url).to eq(user_url(user2))
    expect(page).to have_text(user2.name)
    expect(page).to have_text('Friendship Status: pending')
    expect(page).to have_selector('a', text: 'unfriend')
    expect(Friendship.count).to eq(1)
  end

  scenario "Accepting a friend request", accepting: true do
    login_as(user2)
    visit root_url
    expect(Friendship.count).to eq(1)
    expect(user.friendships.first.status).to eq('pending')
    expect(user2.friendships).to be_empty
    expect(page).to have_text('Friend Requests')
    expect(page).to have_text(user.name, count: 1)
    expect(page).to have_selector('a', text: "accept")
    expect(page).to have_selector('a', text: "ignore")

    click_link('Your Friends')
    expect(page).to have_text(user.name, count: 2)
    expect(page).to have_selector('a', text: "accept", count: 2)

    within('#friend-listing') do
      click_link('accept')
    end
    expect(current_url).to eq(root_url)

    click_link('Your Friends')
    expect(page).to have_text(user.name, count: 1)
    expect(page).to have_selector('a', text: 'unfriend')
    expect(page).to_not have_selector('a', text: "accept")
  end

  scenario "Ignoring a friend request", accepting: true do
    login_as(user2)
    visit root_url
    expect(Friendship.count).to eq(1)

    expect(page).to have_text('Friend Requests')
    expect(page).to have_text(user.name, count: 1)
    expect(page).to have_selector('a', text: "accept")
    expect(page).to have_selector('a', text: "ignore")

    click_link('ignore')
    expect(Friendship.count).to eq(0)
  end

end