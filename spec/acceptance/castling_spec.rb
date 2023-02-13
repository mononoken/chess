# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/pieces'

# RSpec.describe 'Castling API' do
#   context 'when Ra1 and Ke1 have not moved' do
#     let(:board) { Board.new }
#     let(:game) { Chess.new(board:) }

#     let(:king) { King.new(:white) }
#     let(:rook) { Rook.new(:white) }

#     before do
#       board.populate(king, Position.)
#     end

#     it 'moves Rd1 and Kc1' do

#     end
#   end

#   it 'only accepts valid rook moves' do
#     board = Board.new

#     game = Chess.new(board:)

#     rook = Rook.new

#     origin = Position.from_a([4, 2])

#     board.populate(rook, origin)

#     invalid_destination = Position.from_a([5, 5])

#     expect { game.make_move(origin, invalid_destination) }
#       .to raise_error(Chess::InvalidDestinationError)

#     valid_destination = Position.from_a([4, 4])

#     expect { game.make_move(origin, valid_destination) }
#       .not_to raise_error
#   end

#   it 'moves rook across board' do
#     board = Board.new

#     game = Chess.new(board:)

#     rook = Rook.new

#     board.populate(rook, Position.from_a([0, 0]))

#     game.make_move(Position.from_a([0, 0]), Position.from_a([0, 1]))
#     game.make_move(Position.from_a([0, 1]), Position.from_a([0, 3]))
#     game.make_move(Position.from_a([0, 3]), Position.from_a([0, 7]))

#     last_square = board.files[0][7]

#     expect(last_square.content).to eq(rook)
#   end
# end
