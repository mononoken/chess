# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/queen'

RSpec.describe 'Solo Queen API' do
  it 'only accepts valid queen moves' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    queen = Queen.new

    origin = Position.from_a([2, 0])

    board.populate(queen, origin)

    invalid_destination = Position.from_a([4, 1])

    expect { game.play(player, origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = Position.from_a([4, 2])

    expect { game.play(player, origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves queen across board' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    queen = Queen.new

    board.populate(queen, Position.from_a([2, 2]))

    game.play(player, Position.from_a([2, 2]), Position.from_a([1, 1]))
    game.play(player, Position.from_a([1, 1]), Position.from_a([4, 4]))
    game.play(player, Position.from_a([4, 4]), Position.from_a([0, 4]))

    last_square = board.files[0][4]

    expect(last_square.content).to eq(queen)
  end
end
