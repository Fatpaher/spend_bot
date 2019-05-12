require './spec/spec_helper'

RSpec.describe Commands::List do
  describe '#call' do
    it 'returns user events for month' do
      user = build_stubbed(:user)
      message_data = build(
        :message_data,
        user: user,
        command: :list,
        category: nil,
      )

      events = create_list(
        :event,
        2,
        user: user,
      )

      result = described_class.new(message_data).call

      expect(result[:month]).to eq(Date.current.strftime('%B %Y'))
      expect(result[:events]).to match_array(events)
    end

    it 'returns user events for month' do
      user = build_stubbed(:user)
      message_data = build(
        :message_data,
        user: user,
        command: :list,
        category: :food,
      )

      event_1 = create(
        :event,
        user: user,
        category: :food
      )
      _event_2 = create(
        :event,
        user: user,
        category: :drink
      )

      result = described_class.new(message_data).call

      expect(result[:events]).to contain_exactly(event_1)
    end
  end

  describe '#respond_template' do
    it 'returns show' do
      message_data = build(:message_data)
      result = described_class.new(message_data).respond_template

      expect(result).to eq('list')
    end
  end
end
