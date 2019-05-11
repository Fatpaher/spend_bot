require './spec/spec_helper'

RSpec.describe Commands::New do
  describe '#call' do
    it 'works' do
      user = build_stubbed(:user)
      message_data = build(
        :message_data,
        command: :new,
        category: 'food',
        amount: 1.0,
        date: Date.current,
        user: user,
      )

      result = described_class.new(message_data).call

      expect(result).to eq(
        event: Event.last,
      )
    end
  end

  describe '#respond_template' do
    it 'returns new' do
      message_data = build(:message_data)
      result = described_class.new(message_data).respond_template

      expect(result).to eq('new')
    end
  end
end
