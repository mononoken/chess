# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/king'

RSpec.describe 'Solo King API' do
  it 'only accepts valid king moves' do
    board = Board.new

    game = Chess.new(board:)

    king = King.new(:white)

    origin = Position.from_a([2, 0])

    board.populate(king, origin)

    invalid_destination = Position.from_a([4, 1])

    expect { game.make_move(origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = Position.from_a([3, 1])

    expect { game.make_move(origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves king across board' do
    board = Board.new

    game = Chess.new(board:)

    king = King.new(:white)

    board.populate(king, Position.from_a([2, 2]))

    game.make_move(Position.from_a([2, 2]), Position.from_a([1, 1]))
    game.make_move(Position.from_a([1, 1]), Position.from_a([1, 2]))
    game.make_move(Position.from_a([1, 2]), Position.from_a([0, 2]))

    last_square = board.files[0][2]

    expect(last_square.content).to eq(king)
  end
end
