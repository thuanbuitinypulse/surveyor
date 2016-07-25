require 'rails_helper'

RSpec.describe "Surveys", type: :feature do
  describe "GET /surveys" do
    it "works! (now write some real specs)" do
      visit surveys_path
      expect(page.status_code).to eq 200
    end
  end

  describe "GET /surveys/new" do
    it "redirect for guests" do
      visit '/'
      save_and_open_page
    end
  end
end
