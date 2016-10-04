require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context 'Going to website' do
    Steps 'Being welcomed' do
      Given 'i am on the landing page'do
        visit '/'
      end
      Then 'i can see a welcome message' do
        expect(page).to have_content("Welcome")
        expect(page).to have_content("Please sign in as Instructor to host an event")
      end
      Then 'i can sign up and see hello [myname]' do
        click_link 'Sign Up'
        sign_up("test@test.com", "password", "Alex", "Yong")
        expect(page).to have_content("Hello, Alex Yong ( guest )")
      end
      Then 'i can also see a map on the landing page' do
        visit '/'
        find_by_id("map")
      end
    end
  end
end
