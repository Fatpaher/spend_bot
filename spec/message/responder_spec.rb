require './spec/spec_helper'

RSpec.describe Messages::Responder do
  describe '#respond' do
    context '/new command' do
      it 'works' do
        user = build_stubbed :user
        message = FakeTelegramMessage.new(from: user)
        bot = double

        options = {
          bot: bot,
          message: message,
          user: user,
        }

        expect do
          described_class.new(options).respond
        end.to change(Event, :count).by(1)
      end
    end
  end
end
