require './spec/spec_helper'

RSpec.describe 'undo template' do
  context 'events is present' do
    it 'returns no events message' do
      event = build(
        :event
      )

      template = render_template(
        'undo',
        event: event,
      )

      expected_text = "Operation #{event.date.strftime('%d.%m.%y')} #{event.category} #{event.amount} was removed"
      expect(template).to eq(expected_text)
    end
  end

  context 'events is blank' do
    it 'returns no events message' do
      template = render_template(
        'undo',
        event: nil,
      )

      expect(template).to eq('No events to remove')
    end
  end
end
