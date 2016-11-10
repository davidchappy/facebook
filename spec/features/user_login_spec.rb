require "rails_helper"

RSpec.feature "User Login", :type => :feature do

  let!(:user) { create(:user) }

  scenario "User login with invalid information" do
    visit root_url

    fill_in "Email", :with => 'invalid'
    fill_in "Password", :with => ' '
    find(:css, "#user_remember_me").set(true)
    click_button "Log in"

    expect(current_url).not_to eq(root_url)
    expect(current_url).to eq(new_user_session_url)
  end

  scenario "User login with valid information" do
    visit root_url

    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    find(:css, "#user_remember_me").set(true)
    click_button "Log in"

    # http://blog.gaku.net/read-cookie-from-capybara-test-spec/
    expect(page.driver.browser.rack_mock_session.cookie_jar['remember_user_token']).to_not be_nil
    expect(page).to have_text("Signed in successfully.")
    expect(page).to have_text("Logged in as #{user.name}")
    expect(page).to have_text("Your Feed")
  end

  scenario "User login without remembering" do
    visit root_url

    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    find(:css, "#user_remember_me").set(false)
    click_button "Log in"

    # http://blog.gaku.net/read-cookie-from-capybara-test-spec/
    expect(page.driver.browser.rack_mock_session.cookie_jar['remember_user_token']).to be_nil
  end

  scenario "Logging out" do
    login_as(user, scope: :user)
    visit root_url
    click_link "Log Out" 

    expect(page).to have_text("You need to sign in or sign up before continuing.")
    expect(page).to have_text("Sign up", count: 1)
    expect(page).to have_text('Log in')
  end

end