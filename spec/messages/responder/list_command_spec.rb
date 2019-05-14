require './spec/spec_helper'

RSpec.describe '/list command' do
  it 'returns list of events' do
    user = build_stubbed :user
    message = FakeTelegramMessage.new(
      from: user,
      text: '/list April'
    )
    bot = double
    sender = double Messages::Sender

    create(
      :event,
      user: user,
      category: :food,
      amount: 2,
      date: '02.04.2019',
    )
    create(
      :event,
      user: user,
      category: :drink,
      amount: 10.1,
      date: '10.04.2019',
    )

    create(
      :event,
      user: user,
      category: :wine,
      amount: 3,
      date: '29.04.2019',
    )

    options = {
      bot: bot,
      message: message,
      user: user,
      sender: sender,
    }

    allow(sender).to receive(:send)

    Messages::Responder.new(options).respond

    expected_text = [
      "Operations in April 2019",
      '02.04.19 #food - 2',
      '10.04.19 #drink - 10.10',
      '29.04.19 #wine - 3',
    ].join("\n")

    expect(sender).to have_received(:send).with(expected_text)
  end
end
