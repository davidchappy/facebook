require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let!(:user) { create(:user) }

  it "redirects index when not logged in" do
    get :index
    expect(subject).to redirect_to(new_user_session_url)
  end

  it "redirects show when not logged in" do
    get :show, params: { id: user.id }
    expect(subject).to redirect_to(new_user_session_url)
  end

end
