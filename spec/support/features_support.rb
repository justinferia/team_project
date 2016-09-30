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
end
