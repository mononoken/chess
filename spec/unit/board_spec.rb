# frozen_string_literal: true

require_relative './../../lib/board'
require_relative './../../lib/rook'

# rubocop:disable Metrics/BlockLength

RSpec.describe Board do
  subject(:board) { described_class.new(squares) }
  let(:squares) { Array.new(2) { Array.new(2) { Square.new } } }

  describe '#move' do
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

        expect do
          begin
            board.move(origin, destination)
          rescue Board::EmptyOriginError
          end
        end.not_to change { destination_square.content }
      end
    end
  end

  describe '#populate' do
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

# rubocop:enable Metrics/BlockLength
