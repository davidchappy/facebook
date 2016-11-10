require "rails_helper"

RSpec.feature "Users index", :type => :feature do

  let!(:user) { create(:user) }

  scenario "User index" do
    login_as(user)
    visit users_url

    expect(page).to have_text('All Users', count: 2)
    expect(page).to have_selector('ul.users')
    expect(page).not_to have_select('li', text: user.name)
    # can't figure out how to test count of user lis?
  end

end