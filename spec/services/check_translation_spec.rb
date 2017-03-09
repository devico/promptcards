require 'rails_helper'
describe CheckTranslation do

  subject { CheckTranslation.new(params) }

  describe '#call' do

    context "when is check successful" do
      let(:params) { { translated_text: 'house',
                 user_translation: 'house',
                 interval: 1,
                 repeat: 1,
                 efactor: 2.5,
                 attempt: 1 } }
      it "is valid" do
        expect(subject.call[:review_date].strftime('%Y-%m-%d %H:%M')).
          to eq((Time.now + 1.days).strftime('%Y-%m-%d %H:%M'))
        expect(subject.call[:attempt]).to eq(1)
        expect(subject.call[:interval]).to eq(6)
        expect(subject.call[:efactor]).to eq(2.6)
        expect(subject.call[:repeat]).to eq(2)
        expect(subject.call[:state]).to be_truthy
        expect(subject.call[:distance]).to eq(0)
      end
    end

    context "when is check failed" do
      let(:params) { { translated_text: 'house',
                 user_translation: 'RoR',
                 interval: 1,
                 repeat: 1,
                 efactor: 2.5,
                 attempt: 1 } }
      it "is valid" do
        expect(subject.call[:attempt]).to eq(2)
        expect(subject.call[:interval]).to eq(1)
        expect(subject.call[:efactor].round 2).to eq(2.18)
        expect(subject.call[:repeat]).to eq(1)
        expect(subject.call[:state]).to be_falsey
        expect(subject.call[:distance]).to eq(4)
      end
    end
  end
end
