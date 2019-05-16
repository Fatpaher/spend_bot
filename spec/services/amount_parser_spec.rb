require './spec/spec_helper'

RSpec.describe AmountParser do
  context 'works with different formats' do
    commands = {
      '/new 123 #food 12.03.2015' => 123,
      '/new 123.45 12.03.15' => 123.45,
      '/new 123 march 2019' => 123,
      '/new 123 march' => 123,
      '/new 123.21 may' => 123.21,
      '/new 123.21 mar 19' => 123.21,
      '/new 123.21 mar 2019' => 123.21,
      '/list 12.01.19' => nil,
      '/new 123.45 12 mar 19' => 123.45,
      '/new 12.03.2019' => nil,
      '12.12.03' => nil,
      '20.01.19 500.00 #food' => 500.00,
    }

    commands.each do |command, expected_result|
      it command do
        result = described_class.new(command).parse
        expect(result).to eq(expected_result)
      end
    end
  end
end
