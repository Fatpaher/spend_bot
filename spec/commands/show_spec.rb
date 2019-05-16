require './spec/spec_helper'

RSpec.describe Commands::Show do
  describe '#call' do
    it 'returns grouped by category events for current month' do
      user = build_stubbed(:user)
      message_data = build(
        :message_data,
        user: user,
        message: '/show #food 10',
      )

      create_list(
        :event,
        2,
        user: user,
        category: :food,
        amount: 1,
      )

      create(
        :event,
        user: user,
        category: :drink,
        amount: 1,
      )

      result = described_class.new(message_data).call

      expect(result[:month]).to eq(Date.current.strftime('%B %Y'))
      expect(result[:total]).to eq(3)
      expect(result[:grouped_events].length).to eq(2)
      expect(result[:grouped_events].first.category).to eq('#food')
      expect(result[:grouped_events].first.sum).to eq(2)
    end
  end

  describe '#respond_template' do
    it 'returns show' do
      message_data = build(:message_data)
      result = described_class.new(message_data).respond_template

      expect(result).to eq('show')
    end
  end
end
