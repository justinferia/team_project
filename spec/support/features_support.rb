module FeatureSupport

  def sign_up(email, password, first_name, last_name)
    click_link('Sign Up')
    fill_in('user_first_name',:with=>first_name)
    fill_in('user_last_name',:with=>last_name)
    fill_in('user_email',:with=>email)
    fill_in('user[password]',:with=>password)
    fill_in('user_password_confirmation',:with=>password)
    select('Guest',:from => "role[role_name]")
    click_button('Sign up')
  end

  def log_in(email, password)
    click_link('Sign In')
    fill_in('user[email]', :with=>email)
    fill_in('user[password]', :with=>password)
    click_button('Log in')
  end

  def create_workout(class_name, year, month, day, hour, minute, location, category, duration, level, description)
    click_link('New Workout')
    fill_in('workout[name]', :with => class_name)
    select(year, :from => 'workout[date(1i)]')
    select(month, :from => 'workout[date(2i)]')
    select(day, :from => 'workout[date(3i)]')
    select(hour, :from => 'workout[time(4i)]')
    select(minute, :from => 'workout[time(5i)]')
    fill_in('Location', :with => location)
    select(category, :from => 'Category')
    select(duration, :from => 'Duration')
    select(level, :from => 'Level')
    fill_in('Description', :with => description)
    click_button('Create Workout')
  end
end
