require 'rails_helper'

#testing for will and justins story. as a user, I can be able to go to a website to look for workouts that I can go to attend.
RSpec.feature "Workouts", type: :feature do
  context 'going to the workout index' do
    Steps 'being welcomed' do
      Given 'on the workout index page' do
        visit '/workouts'
      end # end of given
      Then 'I can see a list of workouts' do
        expect(page).to have_content 'Workout Listings'
      end
    end #end of steps
  end # end of context

  context 'I want to see a calendar' do
    Steps 'Go to workout index' do
      Given 'i am on the workouts index' do
      visit '/workouts'
      end
      Then 'i want to see a calendar' do
      find_by_id('calendar')
      end
    end
  end #end of context

  context 'I can sign up, log in, and delete my acc' do
    Steps 'Sign up, Sign out, Log in, Destroy acc' do
      Given 'I can go to the home page' do
        visit '/'
      end
      Then 'I can sign up' do
        click_link('Sign Up')
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Instructor',:from => "role[role_name]")
        click_button('Sign up')
        expect(page).to have_content 'Welcome! You have signed up successfully'
      end
      Then 'I can sign out' do
        click_link('Sign Out')
        expect(page).to have_content 'Signed out successfully'
      end
      Then 'I can log in using the acc I previously made' do
        click_link('Log in')
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        click_button('Log in')
        expect(page).to have_content 'Signed in successfully'
      end
      Then 'I can delete my acc' do
        visit '/users/edit'
        click_button('Cancel my account')
        expect(page).to have_content 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
      end
    end
  end

#testing for will and justins second story. As a instructor, I can create a listing for an exercise session. The list listing should include name, istructor, date, time, location, category, price, duration, level, description, so that a user can make an informed desion about attending a class.

# sea and will added in testing for instructors being able to create a class. I can sign up as an instructor and create a class where I have to have an image attached to the workout.
  context 'Signing up as an instructor to add a workout' do
    Steps 'Sign up as an instructor where I need a picture to make a new workout' do
      Given 'on the workout index page' do
        visit '/'
      end # end of given
      Then 'I sign up to be an instructor' do
        click_link('Sign Up')
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Instructor',:from => "role[role_name]")
        click_button('Sign up')
        expect(page).to have_content 'Welcome! You have signed up successfully'
      end
      Then 'I am taken to the edit page to add in my interests, fitness background, and a photo where I decided I do not want to upload information right now' do
        visit '/users/edit'
        click_link('Sign Out')
      end
      When 'I sign back in' do
        click_link('Log in')
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        click_button('Log in')
      end
      Then 'I can go to the workouts page and click a link to go to a form to make a new workout' do

        visit '/workouts'
        click_link('New Workout')
      end
      Then 'I am redirected to upload a picture, interests, and background for my profile' do
        visit '/users/edit'
        fill_in('user[current_password]',:with=>"password")
        fill_in('user_interests',:with=>"I love reading and working out")
        fill_in('user_fitness_background',:with=>"certified with NASM and played college lacrosse")
        attach_file "user_image", File.join(Rails.root, "spec/assets/woman.png")
        click_button('Update')
      end
      Then 'I can go to the workouts page and add a workout' do
        visit '/workouts'
        click_link('New Workout')
      end
      #test for the workout form alerts and validations for posting a workout
      Then 'I can try to fill out a form with out anything selected or filled' do
        fill_in('Name', :with => '')
        fill_in('Location', :with => '')
        fill_in('Description', :with => '')
        click_button('Create Workout')
      end
      Then 'I will see alerts for what I need to select or fill in' do
        expect(page).to have_content "Name can't be blank"
        expect(page).to have_content "Location can't be blank"
        expect(page).to have_content "Category can't be blank"
        expect(page).to have_content "Duration can't be blank"
        expect(page).to have_content "Level can't be blank"
        expect(page).to have_content "Description can't be blank"
      end
      Then 'I can fill out a form' do
        fill_in('Name', :with => 'Triathlon training')
        select('2017', :from => 'workout[date(1i)]')
        select('January', :from => 'workout[date(2i)]')
        select('1', :from => 'workout[date(3i)]')
        select('00', :from => 'workout[time(4i)]')
        select('01', :from => 'workout[time(5i)]')
        fill_in('Location', :with => '3803 Ray St')
        select('Yoga', :from => 'Category')
        select('90 Minutes', :from => 'Duration')
        select('Advanced', :from => 'Level')
        fill_in('Description', :with => 'Swimming, Biking, and Running Training')
        click_button('Create Workout')
      end
      Then 'I am on the details page' do
        expect(page).to have_content 'Triathlon training'
        expect(page).to have_content '01/01/17'
        expect(page).to have_content '12:01 AM'
        expect(page).to have_content '3803 Ray St'
        expect(page).to have_content 'Yoga'
        expect(page).to have_content '90 Minutes'
        expect(page).to have_content 'Advanced'
        expect(page).to have_content 'Swimming, Biking, and Running Training'
      end #end of then
    end #end of given
  end#end of story
 #testing for a guest when they sign up
  context 'Sign up as a guest and not be able to add a workout' do
    Steps 'Sign up as guest and fail to add a workout' do
      Given 'I am on the home page' do
        visit '/'
      end
      Then 'I can click a link to sign up' do
        click_link('Sign Up')
      end
      Then 'I can fill out a form with my information' do
        fill_in('user_email',:with=>"remy@pickles.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Guest',:from => "role[role_name]")
        click_button('Sign up')
      end
      Then 'I receive confirmation that my account was created successfully' do
        expect(page).to have_content 'Welcome! You have signed up successfully'
      end
      Then "I can see a calendar with events that lead to the modal and a pop up" do
        find_by_id('calendar')
      end #end of then
      Then 'I see a list of workouts and cannot create one' do
        expect(page).to_not have_content 'New Workout'
      end
      Then 'If I try to go to the create page through the url I am rejected' do
        visit '/workouts/new'
        expect(page).to have_content 'You must be an instructor to create a workout'
      end#end then
    end#end of Steps
  end#end of context

  context 'I can see filtered classes on the calendar after searching' do
    Steps 'search for classes in search bar' do
      Given 'That I am on the workouts page' do
        visit '/'
        click_link('Sign Up')
        fill_in('user[first_name]',:with=>"Remy")
        fill_in('user[last_name]',:with=>"Pickles")
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Instructor',:from => "role[role_name]")
        click_button("Sign up")
        expect(page).to have_content 'Welcome! You have signed up successfully'
        click_link ('Sign Out')
        log_in('test@test.com','password')
        click_link('Hello, Remy Pickles ( instructor )')
        attach_file "user_image", File.join(Rails.root, "spec/assets/woman.png")
        fill_in('Interests', :with =>"coke")
        fill_in('Fitness background', :with =>"college sports")
        fill_in('user_current_password',:with=>"password")
        click_button('Update')
      end
      Then 'I can fill out a form' do
        click_link('Calendar of Events')
        click_link('New Workout')
        fill_in('Name', :with => 'Sunset Yoga')
        select('2017', :from => 'workout[date(1i)]')
        select('January', :from => 'workout[date(2i)]')
        select('1', :from => 'workout[date(3i)]')
        select('00', :from => 'workout[time(4i)]')
        select('01', :from => 'workout[time(5i)]')
        fill_in('Location', :with => '3803 Ray St')
        select('Yoga', :from => 'Category')
        select('30 Minutes', :from => 'Duration')
        select('Advanced', :from => 'Level')
        fill_in('Description', :with => 'Yoga at Sunset')
        click_button('Create Workout')
      end
      Then 'I am on the details page' do
      expect(page).to have_content 'Sunset Yoga'
      expect(page).to have_content '01/01/17'
      expect(page).to have_content '12:01 AM'
      expect(page).to have_content '3803 Ray St'
      expect(page).to have_content 'Yoga'
      expect(page).to have_content '30 Minutes'
      expect(page).to have_content 'Advanced'
      expect(page).to have_content 'Yoga at Sunset'
      click_link 'Back'
      end #end of then
      Then 'I can create another workout' do
        create_workout('Beach Yoga', '2018', 'January', '1', '00', '01', 'Huntington Beach', 'Yoga', '60 Minutes', 'Beginner', 'Yoga at the beach!')
        click_link 'Back'
      end
      And 'I can filter the classes' do
        select('Yoga', :from => 'search1')
        select('Advanced', :from => 'search2')
        click_button 'searchbutton'
      end
      Then 'I want to see classes for beginners' do
        select('Beginner', :from => 'search2')
        click_button 'searchbutton'
      end
    end
  end


end #end of RSpec
