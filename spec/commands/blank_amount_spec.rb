require './spec/spec_helper'

RSpec.describe Commands::BlankAmount do
  describe '#call' do
    it 'returns error message' do
      message_data = build(:message_data)
      result = described_class.new(message_data).call

      expect(result).to eq(
        error_message: :blank_amount,
      )
    end
  end

  describe '#respond_template' do
    it 'returns error' do
      message_data = build(:message_data)
      result = described_class.new(message_data).respond_template

      expect(result).to eq('error')
    end
  end
end
