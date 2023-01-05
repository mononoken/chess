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

    board.populate(bishop, [2, 0])
    board.populate(king, [4, 0])
    board.populate(knight, [1, 0])
    board.populate(queen, [3, 0])
    board.populate(rook, [0, 0])

    bishop_square = board.squares[2][0]
    king_square = board.squares[4][0]
    knight_square = board.squares[1][0]
    queen_square = board.squares[3][0]
    rook_square = board.squares[0][0]

    expect(bishop_square.content).to eq(bishop)
    expect(king_square.content).to eq(king)
    expect(knight_square.content).to eq(knight)
    expect(queen_square.content).to eq(queen)
    expect(rook_square.content).to eq(rook)
  end

  it 'raises error if piece tries to move to occupied square of same color/player' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    piece_color = :black

    bishop = Bishop.new(piece_color)
    queen = Queen.new(piece_color)

    bishop_position = [2, 0]
    queen_position = [3, 0]

    board.populate(bishop, bishop_position)
    board.populate(queen, queen_position)

    expect { game.play(player, queen_position, bishop_position) }
      .to raise_error(Chess::InvalidDestinationError)

    expect { game.play(player, queen_position, [1, 2]) }
      .not_to raise_error
  end

  it 'raises error if piece tries to move past an occupied square' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    bishop = Bishop.new
    rook = Rook.new

    bishop_position = [2, 0]
    rook_position = [0, 0]
    invalid_destination = [7, 0]
    valid_destination = [0, 7]

    board.populate(bishop, bishop_position)
    board.populate(rook, rook_position)

    expect { game.play(player, rook_position, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    expect { game.play(player, rook_position, valid_destination) }
      .not_to raise_error
  end
end
