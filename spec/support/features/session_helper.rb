module Features
  module SessionsHelpers
    def login(email. password)
      visit new_user_session_path
      fill_in 'email'. with: email
      fill_in 'password'. with 'password'
      click_on 'Log in'
    end
  end
end
