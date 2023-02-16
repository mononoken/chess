# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/bishop'
require_relative './../../lib/pieces/king'
require_relative './../../lib/pieces/knight'
require_relative './../../lib/pieces/queen'
require_relative './../../lib/pieces/rook'

RSpec.describe 'Check Movement API' do
  context 'when board is 3x3' do
    let(:game) { Chess.new(board:) }

    let(:squares_3x3) { Array.new(3) { Array.new(3) { Square.new } } }
    let(:board) { Board.new(files: squares_3x3) }

    let(:white_king) { King.new(:white) }
    let(:white_rook) { Rook.new(:white) }

    let(:black_rook) { Rook.new(:black) }

    context 'when rook is blocking part of king movement' do
      before do
        board.populate(white_king, Position.from_a([2, 0]))
        board.populate(white_rook, Position.from_a([0, 0]))
        board.populate(black_rook, Position.from_a([1, 2]))
      end

      it 'raises error when trying to move king in path of enemy rook' do
        expect { game.send_move(Position.from_a([2, 0]), Position.from_a([1, 0])) }
          .to raise_error(Chess::InvalidDestinationError)
      end

      it 'allows king to move outside of enemy rook path' do
        expect { game.send_move(Position.from_a([2, 0]), Position.from_a([2, 1])) }
          .not_to raise_error(Chess::InvalidDestinationError)
      end
    end

    context 'when rook is defending king' do
      before do
        board.populate(white_king, Position.from_a([1, 0]))
        board.populate(white_rook, Position.from_a([1, 1]))
        board.populate(black_rook, Position.from_a([1, 2]))
      end

      it 'raises error when trying to move rook and putting king in check' do
        expect { game.send_move(Position.from_a([1, 1]), Position.from_a([0, 1])) }
          .to raise_error(Chess::InvalidDestinationError)
      end

      it 'allows rook move that keeps king out of check' do
        expect { game.send_move(Position.from_a([1, 1]), Position.from_a([1, 2])) }
          .not_to raise_error(Chess::InvalidDestinationError)
      end
    end

    context 'when king is currently in check' do
      before do
        board.populate(white_king, Position.from_a([0, 0]))
        board.populate(white_rook, Position.from_a([2, 1]))
        board.populate(black_rook, Position.from_a([0, 2]))
      end

      it 'raises error when attempted move does not defend king' do
        expect { game.send_move(Position.from_a([2, 1]), Position.from_a([2, 0])) }
          .to raise_error(Chess::InvalidDestinationError)
      end

      it 'allows move that defends king' do
        expect { game.send_move(Position.from_a([2, 1]), Position.from_a([0, 1])) }
          .not_to raise_error(Chess::InvalidDestinationError)
      end
    end
  end
end
