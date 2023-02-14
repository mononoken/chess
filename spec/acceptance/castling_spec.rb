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

    before do
      board.populate(king, e1)
      board.populate(rook, a1)
    end

    fit 'accepts c1 as valid move for e1' do
      expect { chess.make_move(e1, c1) }
        .not_to raise_error
    end

    xit 'changes content of a1 to nil' do
      expect { chess.make_move(e1, c1) }
        .to change(a1.square.content)
        .from(rook)
        .to(nil)
    end

    xit 'changes content of c1 to king' do
      expect { chess.make_move(e1, c1) }
        .to change(c1.square.content)
        .from(nil)
        .to(king)
    end

    xit 'changes content of d1 to rook' do
      expect { chess.make_move(e1, c1) }
        .to change(d1.square.content)
        .from(nil)
        .to(rook)
    end

    xit 'changes content of e1 to nil' do
      expect { chess.make_move(e1, c1) }
        .to change(e1.square.content)
        .from(king)
        .to(nil)
    end
  end
end
