require './spec/spec_helper'

RSpec.describe Commands::Undo do
  describe '#call' do
    it 'destory last event' do
      user = build_stubbed(:user)
      message_data = build(
        :message_data,
        user: user,
        command: :undo,
      )

      create_list(
        :event,
        2,
        user: user,
        category: :food,
        amount: 1,
      )

      expect do
        described_class.new(message_data).call
      end.to change(Event, :count).by(-1)
    end

    context 'no events present' do
      it 'destory last event' do
        user = build_stubbed(:user)
        message_data = build(
          :message_data,
          user: user,
          command: :undo,
        )

        expect do
          expect do
            described_class.new(message_data).call
          end.not_to change(Event, :count)
        end.not_to raise_error
      end
    end
  end

  describe '#respond_template' do
    it 'returns show' do
      message_data = build(:message_data)
      result = described_class.new(message_data).respond_template

      expect(result).to eq('undo')
    end
  end
end
