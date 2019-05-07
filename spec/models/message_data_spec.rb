require './spec/spec_helper'

RSpec.describe MessageData do
  describe '#command' do
    it 'gets command from begining of line' do
      result = described_class.new('/new foo 123.29')

      expect(result.command).to eq(:new)
    end
  end
  describe '#amount' do
    context 'only one number present' do
      it 'get amount from it' do
        result = described_class.new('/new 123.29')

        expect(result.amount).to eq(123.29)
      end
    end

    context 'more them one number present' do
      it 'it count only first number' do
        result = described_class.new('/new hey 123.29 321.1')

        expect(result.amount).to eq(123.29)
      end
    end
  end

  describe '#date' do
    it 'returns current date' do
      result = described_class.new('/new 123.29')

      expect(result.date).to eq(Date.today)
    end
  end

  describe '#data' do
    it 'returns all data' do
      result = described_class.new('/new 123.29')

      expect(result.data).to include(
        command: :new,
        amount: 123.29,
        date: Date.today,
      )
    end
  end
end
