require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context 'Going to website' do
    Steps 'Being welcomed' do
      Given 'i am on the landing page'do
        visit '/'
      end
      Then 'i can see a welcome message' do
        expect(page).to have_content("Welcome")
      end
    end
  end
end
