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


#testing for will and justins second story. As a instructor, I can create a listing for an exercise session. The list listing should include name, istructor, date, time, location, category, price, duration, level, description, so that a user can make an informed desion about attending a class.

# sea and will added in testing for instructors being able to create a class. I can sign up as an instructor and create a class.
  context 'adding a workout' do
    Steps 'sign up as instuctor then add a workout' do
      Given 'on the workout index page' do
        visit '/'
        click_link('Click here for class information')
      end # end of given
      Then 'i sign up to be an instructor' do
        click_link('Sign Up')
        fill_in('user_email',:with=>"test@test.com")
        fill_in('user[password]',:with=>"password")
        fill_in('user_password_confirmation',:with=>"password")
        select('Instructor',:from => "role[role_name]")
        click_button('Sign up')
      end
      Then 'expect to see i have signed up successfully' do
        expect(page).to have_content 'Welcome! You have signed up successfully'
      end
      Then 'i can click a link to go to the workouts listing' do
        click_link 'Click here for class information'
      end
      Then 'i can click a link to go to a form to make a new workout' do
        click_link 'New Workout'
      end
      Then 'i can fill out a form' do
        fill_in('Name', :with => 'Triathlon training')
        fill_in('Instructor', :with => 'John Fohnson')
        select('2017', :from => 'workout[date(1i)]')
        select('January', :from => 'workout[date(2i)]')
        select('1', :from => 'workout[date(3i)]')
        select('00', :from => 'workout[time(4i)]')
        select('01', :from => 'workout[time(5i)]')
        fill_in('Location', :with => '3803 Ray St')
        select('Yoga', :from => 'Category')
        fill_in('Price', :with => '5.00')
        fill_in('Duration', :with => '1 hour')
        fill_in('Level', :with => '4')
        fill_in('Description', :with => 'Swimming, Biking, and Running Training')
        click_button('Create Workout')
      end
      Then 'i am on the details page' do
        expect(page).to have_content 'Triathlon training'
        expect(page).to have_content 'John Fohnson'
        expect(page).to have_content '01/01/17'
        expect(page).to have_content '12:01 AM'
        expect(page).to have_content '3803 Ray St'
        expect(page).to have_content 'Yoga'
        expect(page).to have_content '5.0'
        expect(page).to have_content '1 hour'
        expect(page).to have_content '4'
        expect(page).to have_content 'Swimming, Biking, and Running Training'
      end #en of then
    end
  end
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


  context 'going to see working modal' do
    Steps 'being welcomed' do
      Given 'on the workout index page' do
        visit '/workouts'
      end # end of given
      Then 'I can see a list of workouts' do
        expect(page).to have_content 'Workout Listings'
      end
      Then 'I can create a workout' do
        click_link('New Workout')
        fill_in('Name', :with => 'Triathlon training')
        fill_in('Instructor', :with => 'John Fohnson')
        select('2017', :from => 'workout[date(1i)]')
        select('January', :from => 'workout[date(2i)]')
        select('1', :from => 'workout[date(3i)]')
        select('00', :from => 'workout[time(4i)]')
        select('01', :from => 'workout[time(5i)]')
        fill_in('Location', :with => '3803 Ray St')
        select('Yoga', :from => 'Category')
        fill_in('Price', :with => '5.00')
        fill_in('Duration', :with => '1 hour')
        fill_in('Level', :with => '4')
        fill_in('Description', :with => 'Swimming, Biking, and Running Training')
        click_button('Create Workout')
        expect(page).to have_content 'Triathlon training'
      end
    end #end of steps
  end # end of context

  context 'going to see working modal' do
    Steps 'being welcomed' do
      Given 'on the workout index page' do
        visit '/workouts'
      end
      Then "I can see a calendar with events that lead to the modal and a pop up" do
        save_and_open_page
        find_by_id('calendar')
      end #end of then
    end #end of steps
  end #end of context

end #end of RSpec
