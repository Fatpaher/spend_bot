require './spec/spec_helper'

RSpec.describe '/list command' do
  describe '/undo command' do
    it 'delete last event' do
      user = build_stubbed :user
      message = FakeTelegramMessage.new(
        from: user,
        text: '/undo'
      )
      bot = double
      sender = double Messages::Sender

      event_to_delete = create(
        :event,
        user: user,
        category: :drink,
        amount: 10.20,
        date: Date.current,
      )

      create(
        :event,
        user: user,
        category: :food,
        amount: 2,
        date: Date.current - 1.day,
      )

      options = {
        bot: bot,
        message: message,
        user: user,
        sender: sender,
      }

      allow(sender).to receive(:send)

      expect do
        Messages::Responder.new(options).respond
      end.to change(Event, :count).by(-1)

      expected_text = [
        "Operation #{event_to_delete.date.strftime('%d.%m.%y')}",
        event_to_delete.category,
        "10.20 was removed",
      ].join(' ')

      expect(sender).to have_received(:send).with(expected_text)
    end
  end
end
