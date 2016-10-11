require 'rails_helper'
#

RSpec.feature "Twitter",js:true, type: :feature do
  context "go to website and sign in with twitter" do
    Steps 'Go to landing page' do
      Given 'I am on the landing page' do
        visit '/'
      end
      Then 'I click on sign in with twitter' do
        click_link 'Sign in with Twitter'
      end
      Then 'fill out form' do
        fill_in('username_or_email', :with=>"gameboy55115@gmail.com")
        fill_in('password', :with=>'gamecube')
        click_button 'allow'
      end
      Then 'i have successfully signed in' do
        expect(page).to have_content("Successfully authenticated from Twitter account.")
        expect(page).to have_content("Hello, jon ( )")
        click_link "Guest"
      end
      Then 'I should be in the workouts page' do
        expect(page).to have_content("Workout Listings")
      end
      Then 'I go to edit page and see no param to input passwords' do
        click_link "Edit"
        expect(page).to_not have_content("Password confirmation")
        expect(page).to_not have_content("Password")
        expect(page).to_not have_content("Current password")
        expect(page).to_not have_content("Email")
        expect(page).to have_content("First name")
        expect(page).to have_content("Last name")
      end
      Then 'I can fill in the forms that are present' do
        fill_in('user[first_name]',:with=>"jon")
        fill_in('user[last_name]',:with=>"snow")
        click_button('Update')
      end
      Then 'I can sign out and back in and see the changes I made were saved' do
        click_link('Sign Out')
        click_link("Sign in with Twitter")
        expect(page).to have_content('Hello, jon snow ( guest )')
      end
    end
  end
end
