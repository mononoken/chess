# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/pawn'

RSpec.describe 'Solo Pawn API' do
  xit 'accepts special start move' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    pawn = Pawn.new

    origin = [1, 1]

    board.populate(pawn, origin)

    special_destination = [1, 3]

    expect { game.play(player, origin, special_destination) }
      .not_to raise_error
  end

  xit 'moves pawn in the right direction based on color' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    pawn = Pawn.new
4
    board.populate(pawn, [1, 6])

    expect { game.play(player, [1, 6], [1, 5]) }
      .not_to raise_error(Chess::InvalidDestinationError)
  end

  it 'only accepts valid pawn moves' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    pawn = Pawn.new

    origin = [1, 1]

    board.populate(pawn, origin)

    invalid_destination = [2, 2]

    expect { game.play(player, origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = [1, 2]

    expect { game.play(player, origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves pawn across board' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    pawn = Pawn.new
4
    board.populate(pawn, [3, 1])

    game.play(player, [3, 1], [3, 2])
    game.play(player, [3, 2], [3, 3])
    game.play(player, [3, 3], [3, 4])
    game.play(player, [3, 4], [3, 5])
    game.play(player, [3, 5], [3, 6])
    game.play(player, [3, 6], [3, 7])

    last_square = board.files[3][7]

    expect(last_square.content).to eq(pawn)
  end
end
