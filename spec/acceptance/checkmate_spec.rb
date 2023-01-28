# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe 'Checkmate Game API' do
  context "when game is in Fool's mate" do
    let(:board) { Board.new(piece_types:) }

    let(:piece_types) { Chess.chess_pieces }

    let(:player) { Player.new }

    let(:game) { Chess.new(board:, player:) }

    before do
      board.move([5, 1], [5, 2])
      board.move([4, 6], [4, 5])
      board.move([6, 1], [6, 3])
      board.move([3, 7], [7, 3])
    end

    it 'returns true to checkmate?' do
      result = board.checkmate?(:white)

      expect(result).to be(true)
    end
  end
end
