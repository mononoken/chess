# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe 'Checkmate Game API' do
  context "when game of Fool's mate is played" do
    let(:board) { Board.new(piece_types:) }

    let(:piece_types) { Piece.chess_pieces }

    let(:game) { Chess.new(board:) }

    it "plays game of Fool's mate"
    # Create new game.
    # Send moves to game.
    # Expect board to be specific way
  end
end
