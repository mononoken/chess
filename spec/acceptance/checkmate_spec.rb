# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe 'Checkmate Game API' do
  context "when game is in Fool's mate" do
    let(:board) { Board.new(piece_types:) }

    let(:piece_types) { Pieces.piece_types }

    let(:player) { Player.new }

    let(:game) { Chess.new(board:, player:) }

    before do
      board.move(Position.from_a([5, 1]), Position.from_a([5, 2]))
      board.move(Position.from_a([4, 6]), Position.from_a([4, 5]))
      board.move(Position.from_a([6, 1]), Position.from_a([6, 3]))
      board.move(Position.from_a([3, 7]), Position.from_a([7, 3]))
    end

    it 'returns true to checkmate?' do
      result = board.checkmate?(:white)

      expect(result).to be(true)
    end
  end
end
