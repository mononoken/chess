# frozen_string_literal: true

require_relative './../lib/bishop'
require_relative './../lib/squares'

require_relative './../lib/board'

# rubocop:disable Metrics/BlockLength

RSpec.describe Bishop do
  describe '#moves' do
    context 'when bishop is on 5x5 board' do
      subject(:bishop) { described_class.new(squares: squares_5x5) }
      let(:squares_5x5) { instance_double(Squares) }
      context 'when board provides no obstructed coords for bishop paths' do
        before do
          bishop_paths = [
            [[0, 0], [1, 1]], [[3, 3], [4, 4]],
            [[0, 4], [1, 3]], [[3, 1], [4, 0]]
          ]

          obstructed_coords = []

          allow(bishop).to receive(:paths)
            .and_return(bishop_paths)
          allow(squares_5x5).to receive(:obstructed_coords)
            .with(bishop_paths)
            .and_return(obstructed_coords)
        end

        it 'returns full unobstructed bishop movement' do
          full_bishop_movement = [
            [0, 0], [1, 1], [3, 3], [4, 4],
            [0, 4], [1, 3], [3, 1], [4, 0]
          ]
          expect(bishop.moves).to match_array(full_bishop_movement)
        end
      end

      context 'when board provides obstructed coords for two bishop paths' do
        before do
          bishop_paths = [
            [[0, 0], [1, 1]], [[3, 3], [4, 4]],
            [[0, 4], [1, 3]], [[3, 1], [4, 0]]
          ]

          obstructed_coords = [[0, 0], [1, 1], [4, 4]]

          allow(bishop).to receive(:paths)
            .and_return(bishop_paths)
          allow(squares_5x5).to receive(:obstructed_coords)
            .with(bishop_paths)
            .and_return(obstructed_coords)
        end

        it 'returns only unobstructed bishop movement' do
          unobstructed_bishop_movement = [
            [3, 3],
            [0, 4], [1, 3], [3, 1], [4, 0]
          ]
          expect(bishop.moves).to match_array(unobstructed_bishop_movement)
        end
      end
    end
  end

  # Should #valid_coords stubs be for Bishop?
  describe '#movement' do
    context 'when board is 3x3 and bishop has coordinate [2, 0]' do
      subject(:bishop) { described_class.new(coordinate:, squares: squares_3x3) }
      let(:coordinate) { [2, 0] }
      let(:squares_3x3) { instance_double(Squares) }

      before do
        valid_coords_3x3 = (0..2).to_a

        allow(squares_3x3).to receive(:valid_coords)
          .and_return(valid_coords_3x3)
      end

      it 'returns array of valid movement' do
        valid_moves = [[1, 1], [0, 2]]

        expect(bishop.movement).to match_array(valid_moves)
      end
    end

    context 'when board is 5x5 and bishop has coordinate [2, 2]' do
      subject(:bishop) { described_class.new(coordinate:, squares: squares_5x5) }
      let(:coordinate) { [2, 2] }
      let(:squares_5x5) { instance_double(Squares) }

      before do
        valid_coords_5x5 = (0..4).to_a

        allow(squares_5x5).to receive(:valid_coords)
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
