require "rails_helper"

RSpec.feature "User Signup", :type => :feature do

  let!(:user) { create(:user, confirmed_at: nil) }
  let!(:user2) { build(:user, name: "New User", email: "new@sample.com", confirmed_at: nil) }

  scenario "User signup with invalid information" do
    visit root_url

    click_link "Sign up"

    fill_in "Name", :with => ''
    fill_in "Email", :with => ''
    fill_in "Password", :with => ''
    fill_in "Password confirmation", :with => ''
    click_button "Sign up"

    expect(page).to have_text("5 errors prohibited this user from being saved:")
    expect(page).to have_text("Name can't be blank")
    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Password can't be blank")
  end

  scenario "User signup with valid information" do
    visit root_url

    expect(current_url).not_to eq(root_url)
    expect(current_url).to eq(new_user_session_url)

    click_link "Sign up"
    expect(current_url).to eq(new_user_registration_url)
    expect(page).to have_text("Sign up")

    fill_in "Name", :with => user2.name
    fill_in "Email", :with => user2.email
    fill_in "Password", :with => user2.password
    fill_in "Password confirmation", :with => user2.password
    click_button "Sign up"

    expect(page).to have_text("Log in")
    fill_in "Email", :with => user2.email
    fill_in "Password", :with => user2.password
    find(:css, "#user_remember_me").set(true)
    click_button "Log in"

    expect(page).to have_text("You have to confirm your email address before continuing.")    
    expect(current_url).to eq(new_user_session_url)
  end

  scenario "User sign with confirmation" do
    visit root_url

    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Log in"

    expect(page).to have_text("You have to confirm your email address before continuing.")    
    expect(current_url).to eq(new_user_session_url)

    user.confirm
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Log in"

    expect(page).to have_text("Signed in successfully.")    
    expect(current_url).to eq(root_url)
  end

end