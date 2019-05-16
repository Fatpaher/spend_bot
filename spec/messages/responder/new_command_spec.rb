require './spec/spec_helper'

RSpec.describe '/new command' do
  it 'creates new event' do
    user = build_stubbed :user
    event = build(
      :event,
      date: '01.05.2019',
      category: :food,
      amount: 100.11,
    )

    message = FakeTelegramMessage.new(
      from: user,
      text: "/new #{event.amount} #{event.category} #{event.date.strftime('%d.%m.%y')}"
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
      Messages::Responder.new(options).respond
    end.to change(Event, :count).by(1)

    expect(Event.last).to have_attributes(
      user_id: user.id,
      amount: event.amount,
      date: event.date,
      category: event.category,
    )

    expected_text = [
      "Operation #{event.date.strftime('%d.%m.%y')}",
      event.category,
      event.amount,
      'was added',
    ].join(' ')
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
        Messages::Responder.new(options).respond
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
        Messages::Responder.new(options).respond
      end.to change(Event, :count).by(1)

      expect(Event.last).to have_attributes(
        category: '#foo'
      )
    end
  end
end
