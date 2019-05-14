require './spec/spec_helper'

RSpec.describe 'list template' do
  context 'events is present' do
    it 'returns no events message' do
      events = build_list(
        :event,
        2,
        category: :food,
        amount: 1,
      )

      template = render_template(
          'list',
          events: events,
          month: 'April 2019',
      )

      expected_text = [
      "Operations in April 2019",
      '13.05.19 #food - 1',
      '13.05.19 #food - 1',
      ].join("\n")
      expect(template).to eq(expected_text)
    end
  end

  context 'events is blank' do
    it 'returns no events message' do
      template = render_template(
          'list',
          events: Event.none,
          month: 'April 2019',
      )

      expect(template).to eq("No operations in April 2019")
    end
  end
end
