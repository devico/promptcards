require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

describe 'password authentication' do
  describe 'register' do
    before do
      visit root_path
    end

    it 'register TRUE' do
      register('test@test.com', '123321', '123321', 'Зарегистрироваться')
      expect(page).to have_content 'You have signed up successfully. If enabled, a confirmation was sent to your e-mail.'
    end

    it 'password confirmation FALSE' do
      register('test@test.com', '123321', '567890', 'Зарегистрироваться')
      expect(page).to have_content "Значения не совпадают."
    end

    it 'e-mail FALSE' do
      register('test', '123321', '123321', 'Зарегистрироваться')
      expect(page).to have_content 'Не верный формат.'
    end

    it 'e-mail has already been taken' do
      register('test@test.com', '123321', '123321', 'Зарегистрироваться')
      login('test@test.com', '123321', 'Войти')
      click_link 'Выйти'
      register('test@test.com', '123321', '123321', 'Зарегистрироваться')
      expect(page).to have_content 'Не уникальное значение.'
    end

    it 'password is too short' do
      register('test@test.com', '1', '123321', 'Зарегистрироваться')
      expect(page).to have_content 'Короткое значение.'
    end

    it 'password_confirmation is too short' do
      register('test@test.com', '123321', '1', 'Зарегистрироваться')
      expect(page).to have_content 'Значения не совпадают.'
    end
  end

  describe 'authentication' do
    before do
      #@user = FactoryGirl.create(:user)
      create(:user)
      visit root_path
    end

    it 'require_login root' do
      expect(page).to have_content 'Добро пожаловать.'
    end

    it 'authentication TRUE' do
      login('test@test.com', '123321', 'Войти')
      expect(page).to have_content 'Вход в систему выполнен.'
    end

    it 'incorrect e-mail' do
      login('1@1.com', '123321', 'Войти')
      expect(page).to have_content 'Некорректный Email или пароль.'
    end

    it 'incorrect password' do
      login('test@test.com', '56789', 'Войти')
      expect(page).
          to have_content 'Неверный адрес e-mail или пароль.'
    end

    it 'incorrect e-mail and password' do
      login('1@1.com', '56789', 'Войти')
      expect(page).
          to have_content 'Некорректный Email или пароль.'
    end
  end

  describe 'change language' do
    before do
      visit root_path
    end

    it 'home page' do
      click_link 'en'
      expect(page).to have_content 'Welcome.'
    end

    it 'register TRUE' do
      click_link 'en'
      register('test@test.com', '123321', '123321', 'Sing up')
      expect(page).to have_content 'You have signed up successfully. If enabled, a confirmation was sent to your e-mail.'
    end

    it 'default locale' do
      click_link 'en'
      register('test@test.com', '123321', '123321', 'Sing up')
      user = User.find_by_email('test@test.com')
      expect(user.locale).to eq('en')
    end

    it 'available locale' do
      click_link 'en'
      register('test@test.com', '123321', '123321', 'Sing up')
      login('test@test.com', '123321', 'Log in')
      click_link 'User profile'
      fill_in 'user[password]', with: '123321'
      fill_in 'user[password_confirmation]', with: '123321'
      click_button 'Save'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    it 'authentication TRUE' do
      create(:user)
      click_link 'en'
      login('test@test.com', '123321', 'Log in')
      expect(page).to have_content 'Вход в систему выполнен.'
    end
  end
end
