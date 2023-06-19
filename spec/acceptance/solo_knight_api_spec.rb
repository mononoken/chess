# frozen_string_literal: true

require_relative "./../../lib/chess"
require_relative "./../../lib/pieces/knight"

RSpec.describe "Solo Knight API" do
  it "only accepts valid knight moves" do
    board = Board.new

    game = Chess.new(board:)

    knight = Knight.new

    origin = board.position(:c1)

    board.populate(knight, origin)

    invalid_destination = board.position(:c2)

    invalid_movement = Movement.new(origin:, destination: invalid_destination, board:)

    expect { game.send_move(invalid_movement) }
      .to raise_error(Chess::InvalidDestinationError)

    invalid_destination = board.position(:d2)

    invalid_movement = Movement.new(origin:, destination: invalid_destination, board:)

    invalid_movement = Movement.new(origin:, destination: invalid_destination, board:)

    expect { game.send_move(invalid_movement) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = board.position(:d3)

    valid_movement = Movement.new(board:, origin:, destination: valid_destination)

    expect { game.send_move(valid_movement) }
      .not_to raise_error
  end

  it "moves knight across board" do
    board = Board.new

    game = Chess.new(board:)

    knight = Knight.new

    board.populate(knight, board.position(:c3))

    movements = [
      Movement.new(board:, origin: board.position(:c3), destination: board.position(:d5)),
      Movement.new(board:, origin: board.position(:d5), destination: board.position(:f6)),
      Movement.new(board:, origin: board.position(:f6), destination: board.position(:e4))
    ]

    movements.each { |movement| game.send_move(movement) }

    last_position = board.position(:e4)

    expect(last_position.piece).to eq(knight)
  end
end
