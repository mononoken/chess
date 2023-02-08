# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/pawn'

RSpec.describe 'Solo Pawn API' do
  it 'accepts special start move' do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:white)

    origin = Position.from_a([1, 1])

    board.populate(pawn, origin)

    special_destination = Position.from_a([1, 3])

    expect { game.make_move(origin, special_destination) }
      .not_to raise_error
  end

  it 'moves pawn in the right direction based on color' do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:black)

    board.populate(pawn, Position.from_a([1, 6]))

    expect { game.make_move(Position.from_a([1, 6]), Position.from_a([1, 5])) }
      .not_to raise_error(Chess::InvalidDestinationError)
  end

  it 'only accepts valid pawn moves' do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:white)

    origin = Position.from_a([1, 1])

    board.populate(pawn, origin)

    invalid_destination = Position.from_a([2, 2])

    expect { game.make_move(origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = Position.from_a([1, 2])

    expect { game.make_move(origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves pawn across board' do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:white)

    board.populate(pawn, Position.from_a(([3, 1])))

    game.make_move(Position.from_a([3, 1]), Position.from_a([3, 2]))
    game.make_move(Position.from_a([3, 2]), Position.from_a([3, 3]))
    game.make_move(Position.from_a([3, 3]), Position.from_a([3, 4]))
    game.make_move(Position.from_a([3, 4]), Position.from_a([3, 5]))
    game.make_move(Position.from_a([3, 5]), Position.from_a([3, 6]))
    game.make_move(Position.from_a([3, 6]), Position.from_a([3, 7]))

    last_square = board.files[3][7]

    expect(last_square.content).to eq(pawn)
  end
end
