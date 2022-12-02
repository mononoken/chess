# frozen_string_literal: true

require_relative './../lib/bishop'
require_relative './../lib/board'

def square_grid_coordinates(min, max)
  (min..max).to_a.repeated_permutation(2).to_a
end

# rubocop:disable Metrics/BlockLength

RSpec.describe Bishop do
  describe '#valid_moves' do
    subject(:bishop) { described_class.new }
    let(:unobstructed_moves) { [[0, 0], [0, 2], [2, 0], [2, 2]] }

    context 'when there are no obstructions' do
      before do
        allow(bishop).to receive(:movement)
          .and_return(unobstructed_moves)
        allow(bishop).to receive(:obstructed_coords)
          .and_return([])
      end

      it 'returns array of only valid moves' do
        valid_moves = unobstructed_moves

        expect(bishop.valid_moves).to match_array(valid_moves)
      end
    end

    context 'when obstructed coordinates exist' do
      before do
        allow(bishop).to receive(:movement)
          .and_return(unobstructed_moves)
        allow(bishop).to receive(:obstructed_coords)
          .and_return([[0, 0], [2, 2]])
      end

      it 'returns array of only valid moves' do
        valid_moves = [[0, 2], [2, 0]]

        expect(bishop.valid_moves).to match_array(valid_moves)
      end
    end
  end

  describe '#obstructed_coords' do
    # Send self to a board method and expect array of coordinates
  end

  # Should #valid_coords stubs be for Bishop?
  describe '#movement' do
    context 'when board is 3x3 and bishop has coordinate [2, 0]' do
      subject(:bishop) { described_class.new(coordinate:, board: board_3x3) }
      let(:coordinate) { [2, 0] }
      let(:board_3x3) { instance_double(Board) }

      before do
        valid_coords_3x3 = (0..2).to_a

        allow(board_3x3).to receive(:valid_coords)
          .and_return(valid_coords_3x3)
      end

      it 'returns array of valid movement' do
        valid_moves = [[1, 1], [0, 2]]

        expect(bishop.movement).to match_array(valid_moves)
      end
    end

    context 'when board is 5x5 and bishop has coordinate [2, 2]' do
      subject(:bishop) { described_class.new(coordinate:, board: board_5x5) }
      let(:coordinate) { [2, 2] }
      let(:board_5x5) { instance_double(Board) }

      before do
        valid_coords_5x5 = (0..4).to_a

        allow(board_5x5).to receive(:valid_coords)
          .and_return(valid_coords_5x5)
      end

      it 'returns array of valid movement' do
        valid_moves = [
          [0, 0], [1, 1], [3, 3], [4, 4],
          [0, 4], [1, 3], [3, 1], [4, 0]
        ]

        expect(bishop.movement).to match_array(valid_moves)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
