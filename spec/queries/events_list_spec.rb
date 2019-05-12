require './spec/spec_helper'

RSpec.describe Queries::EventsList do
  describe '#call' do
    it 'returns user events' do
      user = build_stubbed(:user)
      date = Date.current

      user_events = create_list(
        :event,
        2,
        user: user,
        date: Date.current
      )

      create(
        :event,
      )

      result = described_class.new(
        user: user,
        category: nil,
        date: date,
      ).call

      expect(result.length).to eq(2)
      expect(result).to match_array(user_events)
    end

    it 'return in period of date' do
      user = build_stubbed(:user)
      current_date = Date.current

      dates = [
        current_date.beginning_of_month + 1.day,
        current_date.beginning_of_month - 1.day,
        current_date.end_of_month + 1.day,
        current_date.end_of_month - 1.day,
      ]

      events = dates.map do |date|
        create(
          :event,
          user: user,
          date: date
        )
      end

      result = described_class.new(
        user: user,
        date: current_date,
        category: nil,
      ).call

      expect(result.length).to eq(2)
      expect(result).to contain_exactly(
        events.first,
        events.last,
      )
    end
  end
end
