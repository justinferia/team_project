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
  context 'adding a workout' do
    Steps 'go to the workout index' do
      Given 'on the workout index page' do
        visit '/workouts'
        click_link('New Workout')
      end # end of given
      Then 'see a form where i can create a new workout' do
        expect(page).to have_content 'New Workout'
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
        fill_in('Category', :with => 'crosstraining')
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
        expect(page).to have_content 'crosstraining'
        expect(page).to have_content '5.0'
        expect(page).to have_content '1 hour'
        expect(page).to have_content '4'
        expect(page).to have_content 'Swimming, Biking, and Running Training'
      end #en of then
      Then 'I am on the show page' do
        click_link('Edit')
      end #end of then
      And 'I want to edit some fields' do
        fill_in('Location', :with => '247 Sesame St')
        fill_in('Instructor', :with => 'Elmo')
        fill_in('Category', :with => 'Jazzercise')
        click_button('Update Workout')
      end
      Then 'I am on the show page again' do
        expect(page).to have_content 'Triathlon training'
        expect(page).to have_content 'Elmo'
        expect(page).to have_content '01/01/17'
        expect(page).to have_content '12:01 AM'
        expect(page).to have_content '247 Sesame St'
        expect(page).to have_content 'Jazzercise'
        expect(page).to have_content '5.0'
        expect(page).to have_content '1 hour'
        expect(page).to have_content '4'
        expect(page).to have_content 'Swimming, Biking, and Running Training'
      end
      Then 'i want to go back to the workouts index' do
        click_link('Back')
        expect(page).to have_content 'Workout Listings'
        expect(page).to have_content 'Elmo'
      end
      Then 'i want to destroy elmo' do
        click_link('Destroy')
        expect(page).to_not have_content 'Elmo'
      end
    end #end of steps
  end # end of context

  #testing for MVP
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
end #end of RSpec
