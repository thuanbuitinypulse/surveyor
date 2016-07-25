require 'rails_helper'

module AuthHelper
  def sign_in(email, password)
    visit new_session_path
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Sign In"
    expect(page).to have_content "Signed in!"
  end
end

RSpec.describe "Surveys", type: :feature do
  include AuthHelper
  describe "GET /surveys/new" do
    it "denies access for guests" do
      visit '/surveys/new'
      # save_and_open_page
      expect(page).to have_content("Access Denied")
      expect(page.status_code).to eq 403
    end

    it "allows users" do
      user = User.create(email: 'harley@example.com', password: 'asdfasdf', admin: true)
      sign_in(user.email, user.password)
      visit '/surveys/new'
      expect(page).to have_content "New Survey"
    end
  end
end
