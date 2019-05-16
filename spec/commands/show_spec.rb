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
      first_event = result[:grouped_events].first
      expect(first_event.category).to eq('#food')
      expect(first_event.sum).to eq(2)
      expect(first_event.percent(result[:total], true)).to eq(' - 66.67%')
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
