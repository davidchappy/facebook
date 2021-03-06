require "rails_helper"

RSpec.feature "Site layout", :type => :feature do

  let!(:user) { create(:user) }

  scenario "Site layout for new user" do
    visit root_url

    expect(page).to have_selector('a', count: 3)
    expect(page).to have_text("Sign up", count: 1)
    expect(page).to have_text("Log in")
    expect(page).to have_text("Forgot your password")
    expect(page).to have_text("Didn't receive confirmation instructions?")
  end

  scenario "Site layout for signed in user" do
    login_as(user, scope: :user)
    visit root_url

    expect(page).to have_text("Log Out")
    expect(page).to have_text("New Post")
    expect(page).to have_text("Your Feed", count: 2)
    expect(page).to have_text("Your Friends")
    expect(page).to have_text("All Users")
    expect(page).to have_text("Your Profile")
  end

end