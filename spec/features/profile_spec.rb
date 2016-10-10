
require 'rails_helper'

#testing for will and justins story. as a user, I can be able to go to a website to look for workouts that I can go to attend.
RSpec.feature "Workouts", type: :feature do
  context 'Signing up as an instructor to get redirected to the instructor profile page' do
    Steps 'Sign up as instuctor then add interests and fitness background' do
      Given 'on the edit user page' do
        visit '/'
      end # end of given
      Then 'I will be directed to the instructors profile page' do
        click_link('Sign Up')
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Instructor',:from => "role[role_name]")
        click_button('Sign up')
        expect(page).to have_content 'Welcome! You have signed up successfully'
      end
      Then 'I have to enter my interests and fitness background' do
        fill_in('user_current_password',:with=>"password")
        fill_in('user_interests',:with=>"tacos")
        fill_in('user_fitness_background',:with=>"hardcore lunges")
        click_button('Update')
      end
      Then 'I am taken to my profile page' do
        expect(page).to have_content 'tacos'
        expect(page).to have_content 'hardcore lunges'
      end
      Given "I'm on the workouts page" do
        visit '/profiles/1'
      end # end of given
      Then 'I can see the list of classes for that instructor' do
        expect(page).to have_content 'My Classes'
        expect(page).to have_content 'Class Name'
        expect(page).to have_content 'Date'
        expect(page).to have_content 'Time'
        expect(page).to have_content 'Location'
        expect(page).to have_content 'Duration'
        expect(page).to have_content 'Class Description'
      end
    end
  end
end
