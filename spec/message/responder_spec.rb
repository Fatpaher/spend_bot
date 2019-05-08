require './spec/spec_helper'

RSpec.describe Messages::Responder do
  describe '#respond' do
    context '/new command' do
      it 'works' do
        user = build_stubbed :user
        message = FakeTelegramMessage.new(
          from: user,
          text: '/new 123'
        )
        bot = double

        options = {
          bot: bot,
          message: message,
          user: user,
        }

        expect do
          described_class.new(options).respond
        end.to change(Event, :count).by(1)

        expect(Event.last).to have_attributes(
          user_id: user.id,
          amount: 123,
          date: be_within(1.minute).of(Date.today.to_time(:utc)),
        )
      end
    end
  end
end
