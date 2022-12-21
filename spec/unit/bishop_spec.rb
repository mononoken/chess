# frozen_string_literal: true

require_relative './../../lib/board'
require_relative './../../lib/bishop'

RSpec.describe Bishop do
  subject(:bishop) { described_class.new }

  describe '#valid_destination?' do
    let(:boundaries) { { files: (0..7), ranks: (0..7) } }
    let(:origin) { [3, 3] }

    context 'when destination is along a diagonal line' do
      let(:valid_destination) { [6, 6] }

      it 'returns true' do
        result = bishop.valid_destination?(origin, valid_destination, boundaries)

        expect(result).to be(true)
      end
    end

    context 'when destination is along a different diagonal line' do
      let(:valid_destination) { [1, 5] }

      it 'returns true' do
        result = bishop.valid_destination?(origin, valid_destination, boundaries)

        expect(result).to be(true)
      end
    end

    context 'when destination is along a horizontal line' do
      let(:invalid_destination) { [0, 3] }

      it 'returns false' do
        result = bishop.valid_destination?(origin, invalid_destination, boundaries)

        expect(result).to be(false)
      end
    end

    context 'when destination is along a vertical line' do
      let(:invalid_destination) { [3, 5] }

      it 'returns false' do
        result = bishop.valid_destination?(origin, invalid_destination, boundaries)

        expect(result).to be(false)
      end
    end
  end
end
