# frozen_string_literal: true

require_relative '../lib/squares'

# rubocop:disable Metrics/BlockLength

RSpec.describe Squares do
  describe '#chess_positions' do
    subject(:squares) { described_class.new }
    let(:all_positions) do
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
      expect(squares.chess_positions).to match_array(all_positions)
    end
  end

  describe '#chess_coordinates' do
    subject(:squares) { described_class.new }
    let(:all_combos) do
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
      expect(squares.chess_coordinates).to match_array(all_combos)
    end
  end
end

# rubocop:enable Metrics/BlockLength
