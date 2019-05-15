require './spec/spec_helper'

RSpec.describe DateParser do
  context 'works with different formats' do
    current_year = Time.current.year
    commands = {
      '/new 123 #food 12.03.2015' => '12.03.2015',
      '/new 123 12.03.15' => '12.03.2015',
      '/new 123 march 2019' => '01.03.2019',
      '/new 123 march' => "01.03.#{current_year}",
      '/new 123.21 may' => "01.05.#{current_year}",
      '/new 123.21 mar 19' => "01.03.#{current_year}",
      '/new 123.21 mar 2019' => "01.03.#{current_year}",
      '/list march 19' => '01.03.2019',
      '/new 123.45 12 mar 19' => '12.03.2019',
      '/new dec 19' => '01.12.2019',
      '12.12.03' => '12.12.2003',
      'jun 2019 500.00 #food' => '01.06.2019',
    }

    commands.each do |command, expected_result|
      it command do
        result = described_class.new(command).parse
        expect(result).to eq(expected_result.to_date)
      end
    end
  end
end
