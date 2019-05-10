require './spec/spec_helper'

RSpec.describe Messages::Responder do
  describe '#respond' do
    context '/new command' do
      it 'works' do
        user = build_stubbed :user
        message = FakeTelegramMessage.new(
          from: user,
          text: '/new 123 01.05.2019'
        )
        bot = double
        sender = double Messages::Sender

        options = {
          bot: bot,
          message: message,
          user: user,
          sender: sender,
        }

        allow(sender).to receive(:send)

        expect do
          described_class.new(options).respond
        end.to change(Event, :count).by(1)

        expect(Event.last).to have_attributes(
          user_id: user.id,
          amount: 123,
          date: Date.parse('01.05.2019'),
          category: '#other',
        )

        expected_text = "Expence added"
        expect(sender).to have_received(:send).with(expected_text)
      end

      context 'without ammount' do
        it 'returns error' do
          user = build_stubbed :user
          message = FakeTelegramMessage.new(
            from: user,
            text: '/new'
          )
          bot = double
          sender = double Messages::Sender

          options = {
            bot: bot,
            message: message,
            user: user,
            sender: sender,
          }
          allow(sender).to receive(:send)

          expect do
            described_class.new(options).respond
          end.not_to change(Event, :count)

          expected_text = 'Hey, you probably forgot to add ammount to your message'
          expect(sender).to have_received(:send).with(expected_text)
        end
      end

      context 'category options' do
        it 'set category from tag ' do
          user = build_stubbed :user
          message = FakeTelegramMessage.new(
            from: user,
            text: '/new 123 #foo'
          )
          bot = double
          sender = Messages::Sender

          options = {
            bot: bot,
            message: message,
            user: user,
            sender: sender,
          }

          allow(sender).to receive(:send)

          expect do
            described_class.new(options).respond
          end.to change(Event, :count).by(1)

          expect(Event.last).to have_attributes(
            category: '#foo'
          )
        end
      end
    end
  end
end
