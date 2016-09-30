require 'rails_helper'
#
RSpec.feature "UserSignUps", type: :feature do
  context 'Going to website' do
    Steps 'being welcomed' do
      Given 'i am on landing page' do
        visit '/'
      end
      Then 'I click on sign up link' do
        click_link('Sign Up')
        expect(page).to have_content("Password confirmation")
      end
      Then 'i can fill out sign up page' do
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Instructor',:from => "role[role_name]")
        click_button('Sign up')
      end
      Then 'i can be acknowleged that i signed up' do
        expect(page).to have_content("You have signed up successfully")
      end
      Then 'i can log out' do
        click_link("Sign Out")
        expect(page).to have_content("Signed out successfully")
      end
      Then "i can sign back in with same login" do
        click_link("Sign In")
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user_password',:with=>"password")
        click_button('Log in')
        expect(page).to have_content("Signed in successfully")
      end
    end
  end

  context 'redirect to edit page' do
    Steps 'being welcomed' do
      Given 'i am on landing page' do
        visit '/'
      end
      Then 'I click on sign up link' do
        click_link('Sign Up')
        expect(page).to have_content("Password confirmation")
      end
      Then 'i can fill out sign up page' do
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Instructor',:from => "role[role_name]")
        click_button('Sign up')
      end
      Then 'i am redirected to the edit page' do
        expect(page).to have_content("Edit")
      end
    end
  end

  context 'redirect to workout page' do
    Steps 'being welcomed' do
      Given 'i am on landing page' do
        visit '/'
      end
      Then 'I click on sign up link' do
        click_link('Sign Up')
        expect(page).to have_content("Password confirmation")
      end
      Then 'i can fill out sign up page' do
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Guest',:from => "role[role_name]")
        click_button('Sign up')
      end
      Then 'i am redirected to the workout page' do
        expect(page).to have_content("Workout")
      end
    end
  end
end
