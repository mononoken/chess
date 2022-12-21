# frozen_string_literal: true

require_relative './../../lib/board'
require_relative './../../lib/king'

RSpec.describe King do
  subject(:king) { described_class.new }

  describe '#valid_destination?' do
    let(:boundaries) { { files: (0..7), ranks: (0..7) } }
    let(:origin) { [3, 3] }

    context 'when destination is a diagonal step' do
      let(:valid_destination) { [4, 4] }

      it 'returns true' do
        result = king.valid_destination?(origin, valid_destination, boundaries)

        expect(result).to be(true)
      end
    end

    context 'when destination is a horizontal step' do
      let(:valid_destination) { [4, 3] }

      it 'returns true' do
        result = king.valid_destination?(origin, valid_destination, boundaries)

        expect(result).to be(true)
      end
    end

    context 'when destination is a vertical step' do
      let(:valid_destination) { [3, 4] }

      it 'returns true' do
        result = king.valid_destination?(origin, valid_destination, boundaries)

        expect(result).to be(true)
      end
    end

    context 'when destination is multiple horizontal steps' do
      let(:invalid_destination) { [0, 3] }

      it 'returns false' do
        result = king.valid_destination?(origin, invalid_destination, boundaries)

        expect(result).to be(false)
      end
    end

    context 'when destination is multiple vertical steps' do
      let(:invalid_destination) { [3, 5] }

      it 'returns false' do
        result = king.valid_destination?(origin, invalid_destination, boundaries)

        expect(result).to be(false)
      end
    end

    context 'when destination is multiple diagonal steps' do
      let(:invalid_destination) { [5, 5] }

      it 'returns false' do
        result = king.valid_destination?(origin, invalid_destination, boundaries)

        expect(result).to be(false)
      end
    end
  end
end
