require './spec/spec_helper'

RSpec.describe 'list template' do
  context 'events is present' do
    it 'returns no events message' do
      event = double(
        category: '#food',
        sum: 1,
        percent: nil,
      )

      template = render_template(
          'show',
          grouped_events: [event],
          month: 'April 2019',
          total: 1,
          show_percent?: false,
      )

      expected_text = [
      "Expences for April 2019",
      '#food 1',
      'Total: 1',
      ].join("\n")
      expect(template).to eq(expected_text)
    end
  end

  context 'events is blank' do
    it 'returns no events message' do
      template = render_template(
          'show',
          grouped_events: Event.none,
          month: 'April 2019',
      )

      expect(template).to eq("No expences in April 2019")
    end
  end
end
