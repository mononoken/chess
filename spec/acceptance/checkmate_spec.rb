# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe 'Checkmate Game API' do
  context "when game is in Fool's mate" do
    let(:board) { Board.new(piece_types:) }

    let(:piece_types) { Pieces.piece_types }

    let(:chess) { Chess.new(board:) }

    before do
      movements = [
        Movement.new(board:, origin: board.position(:f2), destination: board.position(:f3)),
        Movement.new(board:, origin: board.position(:e7), destination: board.position(:e6)),
        Movement.new(board:, origin: board.position(:g2), destination: board.position(:g4)),
        Movement.new(board:, origin: board.position(:d8), destination: board.position(:h4))
      ]

      movements.each { |movement| chess.send_move(movement) }
    end

    it 'returns true to checkmate?' do
      result = board.checkmate?(:white)

      expect(result).to be(true)
    end
  end
end
