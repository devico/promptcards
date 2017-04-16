module LoginHelper
  def login(email, password, action)
    click_link action
    #visit new_user_session_path
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_button action
    #click_on 'Log in'
  end

  def register(email, password, password_confirmation, action)
    visit new_user_registration_path
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password_confirmation
    click_button action
  end
end
