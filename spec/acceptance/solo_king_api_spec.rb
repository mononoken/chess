# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/king'

RSpec.describe 'Solo King API' do
  it 'only accepts valid king moves' do
    board = Board.new

    game = Chess.new(board:)

    king = King.new(:white)

    origin = board.position(:c1)

    board.populate(king, origin)

    invalid_destination = board.position(:e2)

    invalid_movement = Movement.new(origin:, destination: invalid_destination, board:)

    expect { game.send_move(invalid_movement) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = board.position(:d2)

    valid_movement = Movement.new(board:, origin:, destination: valid_destination)

    expect { game.send_move(valid_movement) }
      .not_to raise_error
  end

  it 'moves king across board' do
    board = Board.new

    game = Chess.new(board:)

    king = King.new(:white)

    board.populate(king, board.position(:c3))

    movements = [
      Movement.new(board:, origin: board.position(:c3), destination: board.position(:b2)),
      Movement.new(board:, origin: board.position(:b2), destination: board.position(:b3)),
      Movement.new(board:, origin: board.position(:b3), destination: board.position(:a3))
    ]

    movements.each { |movement| game.send_move(movement) }

    last_square = board.files[0][2]

    expect(last_square.content).to eq(king)
  end
end
