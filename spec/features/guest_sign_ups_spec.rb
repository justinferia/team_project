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
        fill_in('user_first_name',:with=>'Alex')
        fill_in('user_last_name',:with=>'Yong')
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
        expect(page).to have_content("Workout")
      end
    end
  end
# Alex nad Sea-Anna created testing for the instructor sign up page. After  a user signs up as an instructor, they are redirected to the edit user page where they can add in fitness background and interests
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
        fill_in('user_first_name',:with=>'Alex')
        fill_in('user_last_name',:with=>'Yong')
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Instructor',:from => "role[role_name]")
        click_button('Sign up')
      end
      Then 'i am redirected to the edit page' do
        fill_in('user[current_password]',:with=>"password")
        fill_in('user_interests',:with=>"I love reading and working out")
        fill_in('user_fitness_background',:with=>"certified with NASM and played")
        click_button('Update')
      end
      Then 'I am on the home page' do
      end
    end
  end
# created testing for the user sign up page as a guest. When a user signs up as a guest, they redirect to the workout page. when they need to edit their page, they can only do first name last name password and email.
  context 'redirect to workout page and cannot see interests field in edit page' do
    Steps 'being welcomed' do
      Given 'i am on landing page' do
        visit '/'
      end
      Then 'I click on sign up link' do
        click_link('Sign Up')
        expect(page).to have_content("Password confirmation")
      end
      Then 'i can fill out sign up page' do
        fill_in('user_first_name',:with=>'Alex')
        fill_in('user_last_name',:with=>'Yong')
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Guest',:from => "role[role_name]")
        click_button('Sign up')
      end
      Then 'i am redirected to the workout page' do
        expect(page).to have_content("Workout")
        expect(page).to have_content("Alex")
      end
      When 'i want to edit my page as an guest' do
        visit "/users/edit"
        page.should have_no_content("Interests")
        page.should have_no_content("Fitness background")
      end #end of when
    end #end of steps
  end #end of context
  # Sea-Anna and Alex making tests for updating user information for a Guest
  context 'Updating User information'
    Steps 'Updating first name as a guest' do
        Given 'I am on the edit User page as a guest' do
          visit '/'
          sign_up("test@test.com","password","Alex","Yong")
        end
        Then 'i go to edit my  first name' do
          visit '/users/edit'
          fill_in('user_first_name',:with=>'Sea')
          fill_in('user[password]',:with=>"123456")
          fill_in('user_password_confirmation',:with=>"123456")
          fill_in('user[current_password]',:with=>"password")
          click_button('Update')
        end
        Then 'i can see my first name updated and log in with new password' do
          expect(page).to have_content("Sea")
          click_link('Sign Out')
          click_link('Sign In')
          fill_in('user_email',:with=>"test@test.com")
          fill_in('user[password]',:with=>"123456")
          click_button('Log in')
        end
        Then 'i am in the workouts page with my name being Sea' do
          expect(page).to have_content("Sea")
          expect(page).to have_content("Workout")
        end
    end

end # end og RSPEC
