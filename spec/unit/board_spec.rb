# frozen_string_literal: true

require_relative './../../lib/board'
require_relative './../../lib/rook'

RSpec.describe Board do
  subject(:board) { described_class.new(squares) }

  describe '#move' do
    let(:squares) { Array.new(2) { Array.new(2) { Square.new } } }

    context 'when origin square is populated' do
      let(:rook) { instance_double(Rook) }
      let(:origin) { [0, 0] }
      let(:destination) { [0, 1] }

      before do
        board.populate(rook, origin)
      end

      it 'moves origin population to destination square' do
        board.move(origin, destination)

        destination_square = board.squares[0][1]

        expect(destination_square.content).to eq(rook)
      end
    end

    context 'when origin square is empty' do
      let(:origin) { [0, 1] }
      let(:destination) { [1, 1] }

      it 'raises error' do
        expect { board.move(origin, destination) }.to \
          raise_error(Board::EmptyOriginError)
      end

      it 'does not change the desination square' do
        destination_square = board.squares[1][1]

        expect { board.move(origin, destination) rescue :EXPECTED_ERROR }
          .not_to change { destination_square.content }
      end
    end
  end

  describe '#valid_destination?' do
    let(:squares) { Array.new(5) { Array.new(5) { Square.new } } }
    let(:origin) { [1, 0] }
    let(:rook) { instance_double(Rook) }
    let(:boundaries) { { files: (0..squares.count - 1), ranks: (0..squares[0].count - 1) } }

    before :each do
      board.populate(rook, origin)
    end

    context 'when origin rook destination is valid' do
      let(:valid_destination) { [5, 0] }

      before do
        allow(rook).to receive(:valid_destination?)
          .with(origin, valid_destination, boundaries)
          .and_return(true)
      end

      it 'returns true' do
        result = board.valid_destination?(origin, valid_destination)

        expect(result).to be(true)
      end
    end

    context 'when origin rook destination is not valid' do
      let(:invalid_destination) { [5, 5] }

      before do
        allow(rook).to receive(:valid_destination?)
          .with(origin, invalid_destination, boundaries)
          .and_return(false)
      end

      it 'returns false' do
        result = board.valid_destination?(origin, invalid_destination)

        expect(result).to be(false)
      end
    end
  end

  describe '#populate' do
    let(:squares) { Array.new(2) { Array.new(2) { Square.new } } }

    context 'when rook is placed at 0, 0' do
      let(:rook) { instance_double(Rook) }

      it 'changes square content at [0][0] to rook' do
        x = 0
        y = 0
        position = [x, y]

        square = board.squares[x][y]

        board.populate(rook, position)

        expect(square.content).to eq(rook)
      end
    end

    context 'when rook is placed at 1, 0' do
      let(:rook) { instance_double(Rook) }

      it 'changes square content at [1][0] to rook' do
        x = 1
        y = 0
        position = [x, y]

        square = board.squares[x][y]

        board.populate(rook, position)

        expect(square.content).to eq(rook)
      end
    end
  end
end
