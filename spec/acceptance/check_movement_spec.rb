# frozen_string_literal: true

require_relative "./../../lib/chess"
require_relative "./../../lib/pieces/bishop"
require_relative "./../../lib/pieces/king"
require_relative "./../../lib/pieces/knight"
require_relative "./../../lib/pieces/queen"
require_relative "./../../lib/pieces/rook"

RSpec.describe "Check Movement API" do
  context "when board is 3x3" do
    let(:game) { Chess.new(board:) }

    let(:board) { Board.new }

    let(:white_king) { King.new(:white) }
    let(:white_rook) { Rook.new(:white) }

    let(:black_rook) { Rook.new(:black) }

    context "when rook is blocking part of king movement" do
      before do
        board.populate(white_king, board.position(:c1))
        board.populate(white_rook, board.position(:a1))
        board.populate(black_rook, board.position(:b3))
      end

      it "raises error when trying to move king in path of enemy rook" do
        invalid_movement = Movement.new(board:, origin: board.position(:c1), destination: board.position(:b1))

        expect { game.send_move(invalid_movement) }
          .to raise_error(Chess::InvalidDestinationError)
      end

      it "allows king to move outside of enemy rook path" do
        valid_movement = Movement.new(board:, origin: board.position(:c1), destination: board.position(:c2))

        expect { game.send_move(valid_movement) }
          .not_to raise_error
      end
    end

    context "when rook is defending king" do
      before do
        board.populate(white_king, board.position(:b1))
        board.populate(white_rook, board.position(:b2))
        board.populate(black_rook, board.position(:b3))
      end

      it "raises error when trying to move rook and putting king in check" do
        invalid_movement = Movement.new(board:, origin: board.position(:b2), destination: board.position(:a2))

        expect { game.send_move(invalid_movement) }
          .to raise_error(Chess::InvalidDestinationError)
      end

      it "allows rook move that keeps king out of check" do
        valid_movement = Movement.new(board:, origin: board.position(:b2), destination: board.position(:b3))

        expect { game.send_move(valid_movement) }
          .not_to raise_error
      end
    end

    context "when king is currently in check" do
      before do
        board.populate(white_king, board.position(:a1))
        board.populate(white_rook, board.position(:c2))
        board.populate(black_rook, board.position(:a3))
      end

      it "raises error when attempted move does not defend king" do
        invalid_movement = Movement.new(board:, origin: board.position(:c2), destination: board.position(:c1))

        expect { game.send_move(invalid_movement) }
          .to raise_error(Chess::InvalidDestinationError)
      end

      it "allows move that defends king" do
        valid_movement = Movement.new(board:, origin: board.position(:c2), destination: board.position(:a2))

        expect { game.send_move(valid_movement) }
          .not_to raise_error
      end
    end
  end
end
