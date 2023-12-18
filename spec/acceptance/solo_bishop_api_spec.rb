# frozen_string_literal: true

require_relative "../../lib/chess"
require_relative "../../lib/pieces/bishop"

RSpec.describe "new Solo Bishop API" do
  it "only accepts valid bishop moves" do
    board = Board.new

    game = Chess.new(board:)

    bishop = Bishop.new

    origin = board.position(:c1)

    board.populate(bishop, origin)

    invalid_destination = board.position(:e2)

    invalid_movement = Movement.new(origin:, destination: invalid_destination, board:)

    expect { game.send_move(invalid_movement) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = board.position(:a3)

    valid_movement = Movement.new(board:, origin:, destination: valid_destination)

    expect { game.send_move(valid_movement) }
      .not_to raise_error
  end

  it "moves bishop across board" do
    board = Board.new

    game = Chess.new(board:)

    bishop = Bishop.new

    board.populate(bishop, board.position(:a1))

    movements = [
      Movement.new(board:, origin: board.position(:a1), destination: board.position(:b2)),
      Movement.new(board:, origin: board.position(:b2), destination: board.position(:c3)),
      Movement.new(board:, origin: board.position(:c3), destination: board.position(:h8))
    ]

    movements.each { |movement| game.send_move(movement) }

    last_position = board.position(:h8)

    expect(last_position.piece).to eq(bishop)
  end
end
