require './spec/spec_helper'

RSpec.describe MessageData do
  describe '#command' do
    it 'gets command from begining of line' do
      user = build_stubbed :user
      result = described_class.new('/new foo 123.29', user)

      expect(result.command).to eq(:new)
    end

    context 'command is blank' do
      it 'set command as :new' do
        user = build_stubbed :user
        result = described_class.new('foo 123.29', user)

        expect(result.command).to eq(:new)
      end
    end
  end

  describe '#amount' do
    context 'only one number present' do
      it 'get amount from it' do
        user = build_stubbed :user
        result = described_class.new('/new 123.29', user)

        expect(result.amount).to eq(123.29)
      end
    end

    context 'more them one number present' do
      it 'it count only first number' do
        user = build_stubbed :user
        result = described_class.new('/new hey 123.29 321.1', user)

        expect(result.amount).to eq(123.29)
      end
    end

    context 'no numeric present' do
      it 'raise blank_ammount_error' do
        user = build_stubbed :user
        result = described_class.new('/new foo', user)

        expect do
         result.amount
        end.to raise_error(BlankAmountError)
      end
    end
  end

  describe '#date' do
    it 'returns current date' do
      user = build_stubbed :user
      result = described_class.new('/new 123.29', user)

      expect(result.date).to eq(Date.today)
    end

    context 'date present' do
      it 'parse data from message' do
        user = build_stubbed :user
        result = described_class.new('/new 123.29 01.05.2019', user)

        expect(result.date).to eq(Date.parse('01.05.2019'))
      end
    end
  end

  describe '#user' do
    it 'returns user' do
      user = build_stubbed :user
      result = described_class.new('/new 123.29', user)

      expect(result.user).to eq(user)
    end
  end

  describe '#category' do
    context 'tag word present' do
      it 'parse category from tag word' do
        user = build_stubbed :user
        result = described_class.new('/new 123.29 #foo', user)

        expect(result.category).to eq(:foo)
      end
    end

    context 'several tag words' do
      it 'parse first value' do
        user = build_stubbed :user
        result = described_class.new('/new 123.29 #foo #bar', user)

        expect(result.category).to eq(:foo)
      end
    end

    context 'no tag word' do
      it 'set category other' do
        user = build_stubbed :user
        result = described_class.new('/new 123.29', user)

        expect(result.category).to eq(:other)
      end
    end
  end

  describe '#data' do
    it 'returns all data' do
      user = build_stubbed :user
      result = described_class.new('/new 123.29', user)

      expect(result.data).to include(
        command: :new,
        amount: 123.29,
        date: Date.today,
        user: user,
      )
    end
  end
end
