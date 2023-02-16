# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/pawn'

RSpec.describe 'Solo Pawn API' do
  xcontext 'when enemy piece can be taken by pawn on one side' do
    let(:board) { Board.new }
    let(:chess) { Chess.new(board:) }
    let(:pawn) { Pawn.new(:white) }
    let(:bpiece) { Piece.new(:black) }

    let(:b3) { board.positions.position(:b3) }
    let(:a4) { board.positions.position(:a4) }
    let(:b4) { board.positions.position(:b4) }
    let(:c4) { board.positions.position(:c4) }

    before do
      board.populate(pawn, b3)
      board.populate(bpiece, c4)
    end

    it 'allows pawn to take piece' do
      expect { chess.send_move(b3, c4) }
        .not_to raise_error
    end

    it 'does not allow pawn to make take movement to empty square' do
      expect { chess.send_move(b3, a4) }
        .to raise_error
    end

    it 'allows pawn to make normal step' do
      expect { chess.send_move(b3, b4) }
        .not_to raise_error
    end
  end

  it 'accepts special start move' do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:white)

    origin = Position.from_a([1, 1])

    board.populate(pawn, origin)

    special_destination = Position.from_a([1, 3])

    expect { game.send_move(origin, special_destination) }
      .not_to raise_error
  end

  it 'moves pawn in the right direction based on color' do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:black)

    board.populate(pawn, Position.from_a([1, 6]))

    expect { game.send_move(Position.from_a([1, 6]), Position.from_a([1, 5])) }
      .not_to raise_error(Chess::InvalidDestinationError)
  end

  it 'only accepts valid pawn moves' do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:white)

    origin = Position.from_a([1, 1])

    board.populate(pawn, origin)

    invalid_destination = Position.from_a([2, 2])

    expect { game.send_move(origin, invalid_destination) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = Position.from_a([1, 2])

    expect { game.send_move(origin, valid_destination) }
      .not_to raise_error
  end

  it 'moves pawn across board' do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:white)

    board.populate(pawn, Position.from_a(([3, 1])))

    game.send_move(Position.from_a([3, 1]), Position.from_a([3, 2]))
    game.send_move(Position.from_a([3, 2]), Position.from_a([3, 3]))
    game.send_move(Position.from_a([3, 3]), Position.from_a([3, 4]))
    game.send_move(Position.from_a([3, 4]), Position.from_a([3, 5]))
    game.send_move(Position.from_a([3, 5]), Position.from_a([3, 6]))

    last_square = board.files[3][6]

    expect(last_square.content).to eq(pawn)
  end
end
