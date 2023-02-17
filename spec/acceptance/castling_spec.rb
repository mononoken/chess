# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/pieces'

RSpec.describe 'Castling API' do
  context 'when Ra1 and Ke1 have not moved and e1 moves to c1' do
    let(:board) { Board.new }
    let(:chess) { Chess.new(board:) }

    let(:king) { King.new(:white) }
    let(:rook) { Rook.new(:white) }

    let(:a1) { board.positions.position(:a1) }
    let(:c1) { board.positions.position(:c1) }
    let(:d1) { board.positions.position(:d1) }
    let(:e1) { board.positions.position(:e1) }

    let(:movement) { Movement.new(board:, origin: e1, destination: c1) }

    before do
      board.populate(king, e1)
      board.populate(rook, a1)
    end

    it 'accepts c1 as valid move for e1' do
      expect { chess.send_move(movement) }
        .not_to raise_error
    end

    xit 'changes content of a1 to nil' do
      expect { chess.send_move(movement) }
        .to change { a1.square.content }
        .from(rook)
        .to(nil)
    end

    xit 'changes content of c1 to king' do
      expect { chess.send_move(movement) }
        .to change { c1.square.content }
        .from(nil)
        .to(king)
    end

    xit 'changes content of d1 to rook' do
      expect { chess.send_move(movement) }
        .to change(d1.square.content)
        .from(nil)
        .to(rook)
    end

    xit 'changes content of e1 to nil' do
      expect { chess.send_move(movement) }
        .to change { e1.square.content }
        .from(king)
        .to(nil)
    end
  end

  xcontext 'when Ra1 and Ke1 have not moved but pieces obstruct castling' do
    let(:board) { Board.new }
    let(:chess) { Chess.new(board:) }

    let(:king) { King.new(:white) }
    let(:rook) { Rook.new(:white) }

    let(:knight) { Knight.new(:white) } # Obstructing piece

    let(:a1) { board.positions.position(:a1) }
    let(:c1) { board.positions.position(:c1) }
    let(:d1) { board.positions.position(:d1) }
    let(:e1) { board.positions.position(:e1) }

    let(:b1) { board.positions.position(:b1) }

    let(:movement) { Movement.new(board:, origin: e1, destination: c1) }

    before do
      board.populate(king, e1)
      board.populate(rook, a1)

      board.populate(knight, b1)
    end

    it 'rejects c1 move for e1' do
      expect { chess.send_move(movement) }
        .to raise_error
    end
  end

  xcontext 'when either Ra1 or Ke1 has already moved' do
    let(:board) { Board.new }
    let(:chess) { Chess.new(board:) }

    let(:king) { King.new(:white) }
    let(:rook) { Rook.new(:white) }

    let(:a1) { board.positions.position(:a1) }
    let(:c1) { board.positions.position(:c1) }
    let(:d1) { board.positions.position(:d1) }
    let(:e1) { board.positions.position(:e1) }

    let(:movement) { Movement.new(board:, origin: e1, destination: c1) }

    before do
      board.populate(king, e1)
      board.populate(rook, a1)

      board.move()
    end

    it 'rejects c1 move for e1' do
      expect { chess.send_move(movement) }
        .to raise_error
    end
  end
end
