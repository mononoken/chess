# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/rook'

RSpec.describe 'Solo Rook API' do
  it 'only accepts valid rook moves' do
    board = Board.new

    game = Chess.new(board:)

    rook = Rook.new

    origin = board.position(:e3)

    board.populate(rook, origin)

    invalid_destination = board.position(:f6)

    invalid_movement = Movement.new(origin:, destination: invalid_destination, board:)

    expect { game.send_move(invalid_movement) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = board.position(:e5)

    valid_movement = Movement.new(board:, origin:, destination: valid_destination)

    expect { game.send_move(valid_movement) }
      .not_to raise_error
  end

  it 'moves rook across board' do
    board = Board.new

    game = Chess.new(board:)

    rook = Rook.new

    board.populate(rook, board.position(:a1))

    movements = [
      Movement.new(board:, origin: board.position(:a1), destination: board.position(:a2)),
      Movement.new(board:, origin: board.position(:a2), destination: board.position(:a4)),
      Movement.new(board:, origin: board.position(:a4), destination: board.position(:a8))
    ]

    movements.each { |movement| game.send_move(movement) }

    last_square = board.files[0][7]

    expect(last_square.content).to eq(rook)
  end
end
