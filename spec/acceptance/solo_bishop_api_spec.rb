# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/bishop'

RSpec.describe 'Solo Bishop API' do
  it 'only accepts valid bishop moves' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    bishop = Bishop.new

    origin = [2, 0]

    board.populate(bishop, origin)

    invalid_destination = [4, 1]

    expect { game.play(player, origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = [0, 2]

    expect { game.play(player, origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves bishop across board' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    bishop = Bishop.new

    board.populate(bishop, [0, 0])

    game.play(player, [0, 0], [1, 1])
    game.play(player, [1, 1], [3, 3])
    game.play(player, [3, 3], [7, 7])

    last_square = board.files[7][7]

    expect(last_square.content).to eq(bishop)
  end
end
