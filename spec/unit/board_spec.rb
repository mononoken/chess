# frozen_string_literal: true

require_relative './../../lib/board'
require_relative './../../lib/pieces/rook'

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

        expect { board.move(origin, destination) rescue :EXPECTED_ERROR }
          .not_to change { destination_square.content }
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

  describe '#piece' do
    let(:squares) { Array.new(2) { Array.new(2) { instance_double(Square) } } }
    let(:content) { double }
    let(:position) { [1, 0] }

    before do
      allow(squares[position[0]][position[1]]).to receive(:content)
        .and_return(content)
    end

    it 'returns outgoing content query from square of position' do
      expect(board.piece(position)).to be(content)
    end
  end

  fdescribe '#occupied_squares' do
    let(:squares) { Array.new(2) { Array.new(2) { instance_double(Square) } } }

    context 'when three squares have pieces of selected color' do
      let(:matching_squares) { [squares[0][0], squares[0][1], squares[1][0]] }
      let(:mismatch_squares) { [squares[1][1]] }

      let(:color) { :black }

      before do
        matching_squares.each do |square|
          allow(square).to receive(:piece_color?)
            .with(color)
            .and_return(true)
        end

        mismatch_squares.each do |square|
          allow(square).to receive(:piece_color?)
            .with(color)
            .and_return(false)
        end
      end

      it 'returns array of the three occupied squares' do
        expect(board.occupied_squares(color)).to match_array(matching_squares)
      end
    end

    context 'when no squares have pieces of selected color' do
      let(:matching_squares) { [] }
      let(:mismatch_squares) do
        [squares[0][0], squares[0][1], squares[1][0], squares[1][1]]
      end

      let(:color) { :purple }

      before do
        mismatch_squares.each do |square|
          allow(square).to receive(:piece_color?)
            .with(color)
            .and_return(false)
        end
      end

      it 'return nil' do
        expect(board.occupied_squares(color)).to match_array(matching_squares)
      end
    end
  end
end
