# frozen_string_literal: true

require_relative "../../lib/chess"
require_relative "../../lib/pieces/pawn"

RSpec.describe "Solo Pawn API" do
  context "when enemy piece can be taken by pawn on one side" do
    let(:board) { Board.new }
    let(:chess) { Chess.new(board:) }
    let(:pawn) { Pawn.new(:white) }
    let(:bpiece) { Piece.new(:black) }

    let(:b3) { board.position(:b3) }
    let(:a4) { board.position(:a4) }
    let(:b4) { board.position(:b4) }
    let(:c4) { board.position(:c4) }

    let(:valid_take) { Movement.new(board:, origin: b3, destination: c4) }
    let(:invalid_movement) { Movement.new(board:, origin: b3, destination: a4) }
    let(:normal_movement) { Movement.new(board:, origin: b3, destination: b4) }

    before do
      board.populate(pawn, b3)
      board.populate(bpiece, c4)
    end

    it "allows pawn to take piece" do
      expect { chess.send_move(valid_take) }
        .not_to raise_error
    end

    it "does not allow pawn to make take movement to empty square" do
      expect { chess.send_move(invalid_movement) }
        .to raise_error
    end

    it "allows pawn to make normal step" do
      expect { chess.send_move(normal_movement) }
        .not_to raise_error
    end
  end

  it "accepts special start move" do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:white)

    origin = board.position(:b2)

    board.populate(pawn, origin)

    special_destination = board.position(:b4)

    movement = Movement.new(board:, origin:, destination: special_destination)

    expect { game.send_move(movement) }
      .not_to raise_error
  end

  it "moves pawn in the right direction based on color" do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:black)

    board.populate(pawn, board.position(:b7))

    movement = Movement.new(board:, origin: board.position(:b7), destination: board.position(:b6))

    expect { game.send_move(movement) }
      .not_to raise_error(Chess::InvalidDestinationError)
  end

  it "only accepts valid pawn moves" do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:white)

    origin = board.position(:b2)

    board.populate(pawn, origin)

    invalid_destination = board.position(:c3)

    invalid_movement = Movement.new(origin:, destination: invalid_destination, board:)

    expect { game.send_move(invalid_movement) }
      .to raise_error(Chess::InvalidDestinationError)

    valid_destination = board.position(:b3)

    valid_movement = Movement.new(board:, origin:, destination: valid_destination)

    expect { game.send_move(valid_movement) }
      .not_to raise_error
  end

  it "moves pawn across board" do
    board = Board.new

    game = Chess.new(board:)

    pawn = Pawn.new(:white)

    board.populate(pawn, board.position(:d2))

    movements = [
      Movement.new(board:, origin: board.position(:d2), destination: board.position(:d3)),
      Movement.new(board:, origin: board.position(:d3), destination: board.position(:d4)),
      Movement.new(board:, origin: board.position(:d4), destination: board.position(:d5)),
      Movement.new(board:, origin: board.position(:d5), destination: board.position(:d6)),
      Movement.new(board:, origin: board.position(:d6), destination: board.position(:d7))
    ]

    movements.each { |movement| game.send_move(movement) }

    last_position = board.position(:d7)

    expect(last_position.piece).to eq(pawn)
  end
end
