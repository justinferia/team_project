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
      end
    end
  end
end
