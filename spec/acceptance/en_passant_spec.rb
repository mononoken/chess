# frozen_string_literal: true

require_relative "../../lib/chess"
require_relative "../../lib/pieces/pawn"

RSpec.describe "En Passant" do
  context "when enemy pawn advanced two squares on the last move" do
    let(:board) { Board.new }
    let(:chess) { Chess.new(board:) }
    let(:wpawn) { Pawn.new(:white) }
    let(:bpawn) { Pawn.new(:black) }

    # Allow selecting specified board positions using position names as variables.
    %i[a2 a3 a4 a5 b2 b3 b4].each do |position|
      let(position) { board.position(position) }
    end

    let(:passant_movement) { Movement.new(board:, origin: b4, destination: a3) }

    before do
      board.populate(wpawn, a2)
      board.populate(bpawn, b4)

      chess.send_move(Movement.new(board:, origin: a2, destination: a4))
    end

    it "allows en passant capture" do
      expect { chess.send_move(passant_movement) }
        .not_to raise_error
    end

    it "disallows en passant movement if non-sequential" do
      wpawn2 = Pawn.new(:white)
      bpawn2 = Pawn.new(:black)

      board.populate(wpawn2, b2)
      board.populate(bpawn2, a5)

      chess.send_move(Movement.new(board:, origin: b2, destination: b3))

      expect { chess.send_move(passant_movement) }
        .to raise_error
    end
  end
end
