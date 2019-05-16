require './spec/spec_helper'

RSpec.describe '/show command' do
  context 'no date present' do
    it 'returns stat' do
      user = build_stubbed :user
      message = FakeTelegramMessage.new(
        from: user,
        text: '/show 123'
      )
      bot = double
      sender = double Messages::Sender

      create_list(
        :event,
        2,
        user: user,
        category: :food,
        amount: 2,
      )
      create(
        :event,
        user: user,
        category: :drink,
        amount: 10,
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
        "Expences for #{Date.current.strftime('%B %Y')}",
        '#drink 10',
        '#food 4',
        'Total: 14',
      ].join("\n")
      expect(sender).to have_received(:send).with(expected_text)
    end
  end

  context 'month present' do
    it 'returns stat for matched month of current year' do
      user = build_stubbed :user
      message = FakeTelegramMessage.new(
        from: user,
        text: '/show 123 April'
      )
      bot = double
      sender = double Messages::Sender
      year = Date.current.year

      ["02.04.#{year}", "30.03.#{year}"].each do |date|
        create(
          :event,
          user: user,
          category: :drink,
          amount: 10,
          date: date,
        )
      end

      options = {
        bot: bot,
        message: message,
        user: user,
        sender: sender,
      }

      allow(sender).to receive(:send)

      Messages::Responder.new(options).respond

      expected_text = [
        "Expences for April #{year}",
        '#drink 10',
        'Total: 10',
      ].join("\n")
      expect(sender).to have_received(:send).with(expected_text)
    end
  end

  context '-p flag' do
    it 'returns stat' do
      user = build_stubbed :user
      message = FakeTelegramMessage.new(
        from: user,
        text: '/show -p'
      )
      bot = double
      sender = double Messages::Sender

      create_list(
        :event,
        2,
        user: user,
        category: :food,
        amount: 2,
      )
      create(
        :event,
        user: user,
        category: :drink,
        amount: 10,
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
        "Expences for #{Date.current.strftime('%B %Y')}",
        '#drink 10 - 71.43%',
        '#food 4 - 28.57%',
        'Total: 14',
      ].join("\n")
      expect(sender).to have_received(:send).with(expected_text)
    end
  end
end
