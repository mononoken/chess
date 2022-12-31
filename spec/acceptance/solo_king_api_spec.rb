# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/king'

RSpec.describe 'Solo King API' do
  it 'only accepts valid king moves' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    king = King.new

    origin = [2, 0]

    board.populate(king, origin)

    invalid_destination = [4, 1]

    expect { game.play(player, origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = [3, 1]

    expect { game.play(player, origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves king across board' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    king = King.new

    board.populate(king, [2, 2])

    game.play(player, [2, 2], [1, 1])
    game.play(player, [1, 1], [1, 2])
    game.play(player, [1, 2], [0, 2])

    last_square = board.squares[0][2]

    expect(last_square.content).to eq(king)
  end
end
