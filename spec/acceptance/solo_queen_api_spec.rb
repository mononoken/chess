# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/queen'

RSpec.describe 'Solo Queen API' do
  it 'only accepts valid queen moves' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    queen = Queen.new

    origin = [2, 0]

    board.populate(queen, origin)

    invalid_destination = [4, 1]

    expect { game.play(player, origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = [4, 2]

    expect { game.play(player, origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves queen across board' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    queen = Queen.new

    board.populate(queen, [2, 2])

    game.play(player, [2, 2], [1, 1])
    game.play(player, [1, 1], [4, 4])
    game.play(player, [4, 4], [0, 4])

    last_square = board.files[0][4]

    expect(last_square.content).to eq(queen)
  end
end
