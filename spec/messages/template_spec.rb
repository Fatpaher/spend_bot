require './spec/spec_helper'

RSpec.describe Messages::Template do
  describe '#generate' do
    it 'render erb template with data as variables' do
      file_name = 'spec/fixtures/test_template.erb'

      rendered_text = described_class.new(
        file_name,
        foo: :bar,
        baz: :beer
      ).render

      expected_text = "expected text bar\nand beer"

      expect(rendered_text).to eq expected_text
    end
  end
end
