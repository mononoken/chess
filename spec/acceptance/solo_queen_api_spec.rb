# frozen_string_literal: true

require_relative "../../lib/chess"
require_relative "../../lib/pieces/queen"

RSpec.describe "Solo Queen API" do
  it "only accepts valid queen moves" do
    board = Board.new

    game = Chess.new(board:)

    queen = Queen.new

    origin = board.position(:c1)

    board.populate(queen, origin)

    invalid_destination = board.position(:e2)

    invalid_movement = Movement.new(origin:, destination: invalid_destination, board:)

    expect { game.send_move(invalid_movement) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = board.position(:e3)

    valid_movement = Movement.new(board:, origin:, destination: valid_destination)

    expect { game.send_move(valid_movement) }
      .not_to raise_error
  end

  it "moves queen across board" do
    board = Board.new

    game = Chess.new(board:)

    queen = Queen.new

    board.populate(queen, board.position(:c3))

    movements = [
      Movement.new(board:, origin: board.position(:c3), destination: board.position(:b2)),
      Movement.new(board:, origin: board.position(:b2), destination: board.position(:e5)),
      Movement.new(board:, origin: board.position(:e5), destination: board.position(:a5))
    ]

    movements.each { |movement| game.send_move(movement) }

    last_position = board.position(:a5)

    expect(last_position.piece).to eq(queen)
  end
end
