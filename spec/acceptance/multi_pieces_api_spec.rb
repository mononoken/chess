# frozen_string_literal: true

require_relative "../../lib/chess"
require_relative "../../lib/pieces/bishop"
require_relative "../../lib/pieces/king"
require_relative "../../lib/pieces/knight"
require_relative "../../lib/pieces/queen"
require_relative "../../lib/pieces/rook"

RSpec.describe "Multiple (Single Player) Pieces API" do
  it "populates multiple pieces on board" do
    board = Board.new

    bishop = Bishop.new
    king = King.new
    knight = Knight.new
    queen = Queen.new
    rook = Rook.new

    bishop_position = board.position(:c1)
    king_position = board.position(:e1)
    knight_position = board.position(:b1)
    queen_position = board.position(:d1)
    rook_position = board.position(:a1)

    board.populate(bishop, bishop_position)
    board.populate(king, king_position)
    board.populate(knight, knight_position)
    board.populate(queen, queen_position)
    board.populate(rook, rook_position)

    expect(bishop_position.piece).to eq(bishop)
    expect(king_position.piece).to eq(king)
    expect(knight_position.piece).to eq(knight)
    expect(queen_position.piece).to eq(queen)
    expect(rook_position.piece).to eq(rook)
  end

  it "raises error if piece tries to move to occupied square of same color/player" do
    board = Board.new

    game = Chess.new(board:)

    piece_color = :black

    bishop = Bishop.new(piece_color)
    queen = Queen.new(piece_color)

    bishop_position = board.position(:c1)
    queen_position = board.position(:d1)

    board.populate(bishop, bishop_position)
    board.populate(queen, queen_position)

    invalid_movement = Movement.new(board:, origin: queen_position, destination: bishop_position)

    expect { game.send_move(invalid_movement) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_movement = Movement.new(board:, origin: queen_position, destination: board.position(:b3))

    expect { game.send_move(valid_movement) }
      .not_to raise_error
  end

  it "raises error if piece tries to move past an occupied square" do
    board = Board.new

    game = Chess.new(board:)

    bishop = Bishop.new
    rook = Rook.new

    bishop_position = board.position(:c1)
    rook_position = board.position(:a1)
    invalid_destination = board.position(:h1)
    valid_destination = board.position(:a8)

    board.populate(bishop, bishop_position)
    board.populate(rook, rook_position)

    invalid_movement = Movement.new(board:, origin: rook_position, destination: invalid_destination)

    expect { game.send_move(invalid_movement) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_movement = Movement.new(board:, origin: rook_position, destination: valid_destination)

    expect { game.send_move(valid_movement) }
      .not_to raise_error
  end
end
