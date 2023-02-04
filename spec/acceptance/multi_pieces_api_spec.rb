# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/bishop'
require_relative './../../lib/pieces/king'
require_relative './../../lib/pieces/knight'
require_relative './../../lib/pieces/queen'
require_relative './../../lib/pieces/rook'

RSpec.describe 'Multiple (Single Player) Pieces API' do
  it 'populates multiple pieces on board' do
    board = Board.new

    bishop = Bishop.new
    king = King.new
    knight = Knight.new
    queen = Queen.new
    rook = Rook.new

    board.populate(bishop, Position.from_a([2, 0]))
    board.populate(king, Position.from_a([4, 0]))
    board.populate(knight, Position.from_a([1, 0]))
    board.populate(queen, Position.from_a([3, 0]))
    board.populate(rook, Position.from_a([0, 0]))

    bishop_square = board.files[2][0]
    king_square = board.files[4][0]
    knight_square = board.files[1][0]
    queen_square = board.files[3][0]
    rook_square = board.files[0][0]

    expect(bishop_square.content).to eq(bishop)
    expect(king_square.content).to eq(king)
    expect(knight_square.content).to eq(knight)
    expect(queen_square.content).to eq(queen)
    expect(rook_square.content).to eq(rook)
  end

  it 'raises error if piece tries to move to occupied square of same color/player' do
    board = Board.new

    game = Chess.new(board:)

    piece_color = :black

    bishop = Bishop.new(piece_color)
    queen = Queen.new(piece_color)

    bishop_position = Position.from_a([2, 0])
    queen_position = Position.from_a([3, 0])

    board.populate(bishop, bishop_position)
    board.populate(queen, queen_position)

    expect { game.play(queen_position, bishop_position) }
      .to raise_error(Chess::InvalidDestinationError)

    expect { game.play(queen_position, Position.from_a([1, 2])) }
      .not_to raise_error
  end

  it 'raises error if piece tries to move past an occupied square' do
    board = Board.new

    game = Chess.new(board:)

    bishop = Bishop.new
    rook = Rook.new

    bishop_position = Position.from_a([2, 0])
    rook_position = Position.from_a([0, 0])
    invalid_destination = Position.from_a([7, 0])
    valid_destination = Position.from_a([0, 7])

    board.populate(bishop, bishop_position)
    board.populate(rook, rook_position)

    expect { game.play(rook_position, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    expect { game.play(rook_position, valid_destination) }
      .not_to raise_error
  end
end
