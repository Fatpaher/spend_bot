require './spec/spec_helper'

RSpec.describe MessageData do
  describe '#ammount' do
    context 'number persent in message' do
      it 'parse amount from it' do
        message_data = described_class.new('/new 123.45')

        expect(message_data.amount).to eq(123.45)
      end
    end

    context 'several numbers present' do
      it 'parses first value' do
        message_data = described_class.new('/new 123.45 321.12 1')

        expect(message_data.amount).to eq(123.45)
      end
    end
  end

  describe '#command' do
    it 'get command value from beggining of message' do
      message_data = described_class.new('/new 123.45 321.12 1')

      expect(message_data.command).to eq(:new)
    end
  end

  describe 'date' do
    context 'date not present in message' do
      it 'take today date' do
        message_data = described_class.new('/new 123.45 321.12 1')

        expect(message_data.date).to eq(Date.today)
      end
    end
  end

  describe 'data' do
    it 'returns all message data' do
      message_data = described_class.new('/new 123.45 321.12 1')

      expect(message_data.data).to include(
        command: :new,
        amount: 123.45,
        date: Date.today
      )
    end
  end
end
