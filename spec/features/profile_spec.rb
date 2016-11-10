require "rails_helper"

RSpec.feature "Site layout", :type => :feature do

  let!(:user) { create(:user) }

  scenario "User Profile" do
    login_as(user)
    visit user_url(user)

    expect(page).to have_text(user.name)
    expect(page).to have_selector('a', text: "Edit Profile")
    expect(page).to have_text(user.posts.count)
    expect(page).to have_text(user.comments.count)
  end

  scenario "User Edit Profile" do
    login_as(user)
    visit user_url(user)

    click_link("Edit Profile")
    expect(page).to have_text("Edit User")
    expect(page).to have_selector('form', id: "edit_user")
    expect(page).to have_text("Name")
    expect(page).to have_text("Email")
    expect(page).to have_text("Password")
    expect(page).to have_text("Password confirmation")
    expect(page).to have_text("Cancel my account")
  end

end