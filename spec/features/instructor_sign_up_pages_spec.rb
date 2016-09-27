require 'rails_helper'

RSpec.feature "InstructorSignUpPage", type: :feature do

  context 'Going to the instructors page' do
    Steps 'Seeing the list of instructors' do
      Given 'I am on the instructor page' do
        visit '/instructors'
      end
      Then 'I can create a new instructor' do
        click_link 'New Instructor'
      end
      When 'I am on the add new instructor page' do
        fill_in 'Name', with: 'Sea'
        fill_in 'Description', with: 'I love to play sports and run'
      end
      And 'I submit the information' do
        click_button 'Create Instructor'
      end
      Then 'I can see the new instructors info' do
        expect(page).to have_content('Name: Sea')
        expect(page).to have_content('Description: I love to play sports and run')
      end
      When 'I am on the new instructor info page' do
        click_link 'Back'
      end
      Then 'I can go back to the instructors page' do

      end
    end
  end

end
