require "rails_helper"

RSpec.feature "Post interface", :type => :feature do

  let!(:user) { create(:user) }
  let!(:user2) { create(:user,  name: "New User", 
                                email: "new@sample.com", 
                                confirmed_at: Date.today) }
  let!(:friendship) { Friendship.create(user_id: user.id,  friend_id: user2.id, 
                                                          status: 'friends') }
  let!(:post) { create(:post, user_id: user.id) }
  let!(:post2) { create(:post, user_id: user2.id, content: "This is user 2's post") }

  scenario "Creating a post" do
    login_as(user)
    visit root_url

    click_link('New Post')
    expect(current_url).to eq(new_post_url)
    expect(page).to have_text("New Post", count: 2)
    expect(page).to have_text("Content")

    fill_in "Content", with: "This is my new post."
    click_button('Create Post')
    expect(current_url).to eq(root_url)
    expect(page).to have_text("Your Feed")
    expect(page).to have_text("This is my new post.")
    expect(page).to have_text("0 likes")
    expect(page).to have_selector('a', text: "0 comments")
  end

  scenario "Feed" do
    login_as(user)
    visit root_url

    expect(page).to have_text("Your Feed")
    expect(page).to have_text(user.name, count: 2)
    expect(page).to have_text(post.content)

    expect(page).to have_text(user2.name)
    expect(page).to have_text(post2.content)
    expect(page).to have_selector('li.post_item', count: user.feed.length)
  end

end