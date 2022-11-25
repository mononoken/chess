# frozen_string_literal: true

require_relative '../lib/squares'

# rubocop:disable Metrics/BlockLength

RSpec.describe Squares do
  xdescribe '#piece' do
    context 'when designated square position has content' do
      subject(:squares) { described_class.new(squares: [square]) }
      let(:square) { instance_double(Square) }
      let(:piece) { instance_double(Piece) }
      let(:position) { :xy }

      before do
        allow(square).to receive(:position).and_return(position)
        allow(square).to receive(:content).and_return(piece)
      end

      it 'returns object in content' do
        expect(squares.piece(position)).to eq(piece)
      end
    end
  end

  describe '#colors' do
    context 'when three squares have different colors' do
      subject(:rgb_squares) do
        described_class.new(squares: [square_r, square_g, square_b])
      end
      let(:square_r) { instance_double(Square) }
      let(:square_g) { instance_double(Square) }
      let(:square_b) { instance_double(Square) }

      before do
        allow(square_r).to receive(:color).and_return(:red)
        allow(square_g).to receive(:color).and_return(:green)
        allow(square_b).to receive(:color).and_return(:blue)
      end

      it 'returns an array of the colors' do
        colors = %i[red green blue]
        expect(rgb_squares.colors).to eq(colors)
      end
    end
  end
end

RSpec.describe Squares do
  xcontext 'when squares is chess squares' do
    subject(:chess_squares) { described_class.new }
    describe '#colors' do
      it 'returns an array of alternating black/white colors' do
        alternating_colors = [:black, :white] * 32

        expect(chess_squares.colors).to eq(alternating_colors)
      end
    end

    describe '#positions' do
      let(:chess_positions) do
        [
          :a1, :a2, :a3, :a4, :a5, :a6, :a7, :a8,
          :b1, :b2, :b3, :b4, :b5, :b6, :b7, :b8,
          :c1, :c2, :c3, :c4, :c5, :c6, :c7, :c8,
          :d1, :d2, :d3, :d4, :d5, :d6, :d7, :d8,
          :e1, :e2, :e3, :e4, :e5, :e6, :e7, :e8,
          :f1, :f2, :f3, :f4, :f5, :f6, :f7, :f8,
          :g1, :g2, :g3, :g4, :g5, :g6, :g7, :g8,
          :h1, :h2, :h3, :h4, :h5, :h6, :h7, :h8,
        ]
      end
      it 'returns an array of chess positions as symbols' do
        expect(chess_squares.positions).to match_array(chess_positions)
      end
    end

    describe '#coordinates' do
      let(:chess_coordinates) do
        [
          [0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
          [1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
          [2, 0], [2, 1], [2, 2], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7],
          [3, 0], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7],
          [4, 0], [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7],
          [5, 0], [5, 1], [5, 2], [5, 3], [5, 4], [5, 5], [5, 6], [5, 7],
          [6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7],
          [7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7],
        ]
      end
      it 'returns an array of all [x, y] combos for a chess board' do
        expect(chess_squares.coordinates).to match_array(chess_coordinates)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
