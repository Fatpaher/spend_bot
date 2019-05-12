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

    context '/show' do
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

          described_class.new(options).respond

          expected_text = [
            "Expences for #{Date.current.strftime('%B %Y')}",
            '#drink 10',
            '#food 4',
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

          described_class.new(options).respond

          expected_text = [
            "Expences for April #{year}",
            '#drink 10',
          ].join("\n")
          expect(sender).to have_received(:send).with(expected_text)
        end
      end
    end
  end

  describe '/list' do
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
        amount: 10,
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

      described_class.new(options).respond

      expected_text = [
        "Operations in April 2019",
        '02.04.19 #food - 2',
        '10.04.19 #drink - 10',
        '29.04.19 #wine - 3',
      ].join("\n")

      expect(sender).to have_received(:send).with(expected_text)
    end
  end
end
