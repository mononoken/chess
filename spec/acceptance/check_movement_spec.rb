# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/bishop'
require_relative './../../lib/pieces/king'
require_relative './../../lib/pieces/knight'
require_relative './../../lib/pieces/queen'
require_relative './../../lib/pieces/rook'

RSpec.describe 'Check Movement API' do
  let(:game) { Chess.new(board:, player:) }

  let(:squares_3x3) { Array.new(3) { Array.new(3) { Square.new } } }
  let(:board) { Board.new(squares_3x3) }

  let(:player) { Player.new }

  let(:white_king) { King.new(:white) }
  let(:white_rook) { Rook.new(:white) }

  let(:black_rook) { Rook.new(:black) }

  context 'when rook is defending king' do
    before do
      board.populate(white_king, [1, 0])
      board.populate(white_rook, [1, 1])
      board.populate(black_rook, [1, 2])
    end

    it 'raises error when trying to move rook and putting king in check' do
      expect { game.play(player, [1, 1], [0, 1]) }
        .to raise_error(Chess::InvalidDestinationError)
    end

    xit 'allows rook move that keeps king out of check' do
      expect { game.play(player, [1, 1], [1, 2]) }
        .not_to raise_error(Chess::InvalidDestinationError)
    end
  end
end
