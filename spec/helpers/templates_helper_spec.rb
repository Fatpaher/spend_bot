require './spec/spec_helper'

RSpec.describe TemplatesHelper do
  let(:module_klass) { Class.new { include TemplatesHelper } }

  describe '#formated_numnber' do
    context 'number is n.00' do
      it 'returns integer' do
        result = module_klass.new.pretty_currency(1.0)
        expect(result).to eq('1')
      end
    end

    context 'number is n.n' do
      it 'returns integer' do
        result = module_klass.new.pretty_currency(1.1)
        expect(result).to eq('1.10')
      end
    end

    context 'number is n.nn' do
      it 'returns integer' do
        result = module_klass.new.pretty_currency(1.11)
        expect(result).to eq('1.11')
      end
    end
  end
end
