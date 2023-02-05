# frozen_string_literal: true

require_relative './../../lib/positions'

RSpec.xdescribe Positions do
  subject(:positions) { described_class.new(files:) }
  let(:files) { double }

  describe '#valid_origin?' do
    context 'when position has a piece of matching color' do
      it 'returns true'
    end
  end
end
