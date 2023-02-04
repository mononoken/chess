# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/rook'

RSpec.describe 'Solo Rook API' do
  it 'only accepts valid rook moves' do
    board = Board.new

    game = Chess.new(board:)

    rook = Rook.new

    origin = Position.from_a([4, 2])

    board.populate(rook, origin)

    invalid_destination = Position.from_a([5, 5])

    expect { game.play(origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = Position.from_a([4, 4])

    expect { game.play(origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves rook across board' do
    board = Board.new

    game = Chess.new(board:)

    rook = Rook.new

    board.populate(rook, Position.from_a([0, 0]))

    game.play(Position.from_a([0, 0]), Position.from_a([0, 1]))
    game.play(Position.from_a([0, 1]), Position.from_a([0, 3]))
    game.play(Position.from_a([0, 3]), Position.from_a([0, 7]))

    last_square = board.files[0][7]

    expect(last_square.content).to eq(rook)
  end
end
