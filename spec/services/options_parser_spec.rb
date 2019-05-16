require './spec/spec_helper'

RSpec.describe OptionsParser do
  context 'works with different formats' do
    commands = {
      '/new 123 #food -p 12.03.2015' => [:percent],
      '/new 123.45 12.03.15' => nil,
      '/new 123 -p march 2019 ' => [:percent],
      '/new 123 march -p' => [:percent],
      '/new -p 123 march' => [:percent],
    }

    commands.each do |command, expected_result|
      it command do
        result = described_class.new(command).parse
        expect(result).to eq(expected_result)
      end
    end
  end
end
