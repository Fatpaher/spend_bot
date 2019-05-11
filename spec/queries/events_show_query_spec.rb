require './spec/spec_helper'

RSpec.describe EventsShowQuery do
  describe '#call' do
    it 'returns user events' do
      user = build_stubbed(:user)
      category = :food
      date = Date.current

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

      create(
        :event,
        category: :food,
        amount: 1,
      )

      result = described_class.new(
        user: user,
        category: category,
        date: date,
      ).call

      expect(result.length).to eq(2)
      expect(result.first.category).to eq('#drink')
      expect(result.first.sum).to eq(1)
      expect(result.last.category).to eq('#food')
      expect(result.last.sum).to eq(2)
    end

    it 'return in period of date' do
      user = build_stubbed(:user)
      category = :food
      current_date = Date.current

      dates = [
        current_date.beginning_of_month - 1.minute,
        current_date.beginning_of_month + 1.minute,
        current_date.end_of_month - 1.minute,
        current_date.end_of_month + 1.minute,
      ]

      dates.each do |date|
        create(
          :event,
          user: user,
          category: :food,
          amount: 1,
          date: date
        )
      end

      result = described_class.new(
        user: user,
        category: category,
        date: date,
      ).call

      expect(result.length).to eq(1)
      expect(result.first.sum).to eq(2)
    end
  end
end
