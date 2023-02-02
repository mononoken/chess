# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/knight'

RSpec.describe 'Solo Knight API' do
  it 'only accepts valid knight moves' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    knight = Knight.new

    origin = Position.from_a([2, 0])

    board.populate(knight, origin)

    invalid_destination = Position.from_a([2, 1])

    expect { game.play(player, origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    invalid_destination = Position.from_a([3, 1])

    expect { game.play(player, origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = Position.from_a([3, 2])

    expect { game.play(player, origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves knight across board' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    knight = Knight.new

    board.populate(knight, Position.from_a([2, 2]))

    game.play(player, Position.from_a([2, 2]), Position.from_a([3, 4]))
    game.play(player, Position.from_a([3, 4]), Position.from_a([5, 5]))
    game.play(player, Position.from_a([5, 5]), Position.from_a([4, 3]))

    last_square = board.files[4][3]

    expect(last_square.content).to eq(knight)
  end
end
