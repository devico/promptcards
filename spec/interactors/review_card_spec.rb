require 'rails_helper'
require 'support/helpers/trainer_helper.rb'
include TrainerHelper

describe ReviewCard do

  describe '#call' do
      it 'correct translation' do
        card = FactoryGirl.create(:card, :with_user_and_block)
        ReviewCard.call(card_id: card.id, user_translation: 'house')
        card = Card.find_by(id: card.id)
        expect(card.review_date.strftime('%Y-%m-%d %H:%M')).
            to eq((Time.zone.now + 1.days).strftime('%Y-%m-%d %H:%M'))
        expect(card.interval).to eq(6)
        expect(card.repeat).to eq(2)
        expect(card.attempt).to eq(1)
      end

      it 'incorrect translation' do
        card = create(:card, :with_user_and_block, quality: 4)
        ReviewCard.call(card_id: card.id, user_translation: 'RoR')
        card = Card.find_by(id: card.id)
        expect(card.interval).to eq(1)
        expect(card.repeat).to eq(1)
        expect(card.attempt).to eq(2)
        expect(card.efactor).to eq(2.18)
        expect(card.quality).to eq(2)
      end

      it 'correct and incorrect translation' do
        card = create(:card, :with_user_and_block, quality: 4)
        ReviewCard.call(card_id: card.id, user_translation: 'house')
        card = Card.find_by(id: card.id)
        card.update(review_date: Time.zone.now)
        ReviewCard.call(card_id: card.id, user_translation: 'house')
        card = Card.find_by(id: card.id)
        card.update(review_date: Time.zone.now)
        ReviewCard.call(card_id: card.id, user_translation: 'RoR')
        ReviewCard.call(card_id: card.id, user_translation: 'house')
        card = Card.find_by(id: card.id)
        expect(card.review_date.strftime('%Y-%m-%d %H:%M')).
            to eq((Time.zone.now + 1.days).strftime('%Y-%m-%d %H:%M'))
        expect(card.interval).to eq(6)
        expect(card.repeat).to eq(2)
        expect(card.attempt).to eq(1)
        expect(card.efactor).to eq(2.38)
        expect(card.quality).to eq(4)
      end
  end
end
