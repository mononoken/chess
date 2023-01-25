# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/knight'

RSpec.describe 'Solo Knight API' do
  it 'only accepts valid knight moves' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    knight = Knight.new

    origin = [2, 0]

    board.populate(knight, origin)

    invalid_destination = [2, 1]

    expect { game.play(player, origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    invalid_destination = [3, 1]

    expect { game.play(player, origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = [3, 2]

    expect { game.play(player, origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves knight across board' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    knight = Knight.new

    board.populate(knight, [2, 2])

    game.play(player, [2, 2], [3, 4])
    game.play(player, [3, 4], [5, 5])
    game.play(player, [5, 5], [4, 3])

    last_square = board.files[4][3]

    expect(last_square.content).to eq(knight)
  end
end
