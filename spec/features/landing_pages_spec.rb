require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  # testing for what is on the landing page
  context 'Going to website' do
    Steps 'Being welcomed' do
      Given 'i am on the landing page'do
        visit '/'
      end #end of given
      Then 'i can see a welcome message' do
        expect(page).to have_content("Welcome")
        expect(page).to have_content("Please sign in as Instructor to host an event")
        expect(page).to have_content("Please sign in as Guest to RSVP for events")
      end #end of then
      Then 'i can sign up and see hello [myname]' do
        click_link 'Sign Up'
        sign_up("test@test.com", "password", "Alex", "Yong")
        expect(page).to have_content("Hello, Alex Yong ( guest )")
      end
      Then 'i can also see a map on the landing page' do
        visit '/'
        find_by_id("map")
      end
      And 'i can click on a button to show me the calendar of events' do
      visit '/'
      click_link 'Calendar of Events'
      find_by_id('calendar')
      end #end of And
    end #end of stories
  end  #end of steps
end #end of RSPEC
