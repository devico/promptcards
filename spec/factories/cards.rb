FactoryGirl.define do
  factory :card do
    original_text 'дом'
    translated_text 'house'
    interval 1
    repeat 1
    efactor 2.5
    quality 5
    attempt 1
    user
    block
  end

  trait :with_user_and_block do
    user { FactoryGirl.create :user, email: 'test@test.ru',
                                         password: '12345',
                                         password_confirmation: '12345',
                                         locale: 'ru' }
    block { FactoryGirl.create :block }
  end
end
