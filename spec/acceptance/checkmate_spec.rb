# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/bishop'
require_relative './../../lib/pieces/king'
require_relative './../../lib/pieces/knight'
require_relative './../../lib/pieces/queen'
require_relative './../../lib/pieces/rook'

RSpec.describe 'Checkmate Game API' do
  context "when game is in Fool's mate" do
    let(:game) { Chess.new(board:, player:) }

    let(:fools_squares) do
      {
        a1: ['R', :white],
        b1: ['N', :white],
        c1: ['B', :white],
        d1: ['Q', :white],
        e1: ['K', :white],
        f1: ['B', :white],
        g1: ['N', :white],
        h1: ['R', :white],
        a2: ['P', :white],
        b2: ['P', :white],
        c2: ['P', :white],
        d2: ['P', :white],
        e2: ['P', :white],
        f3: ['P', :white],
        g4: ['P', :white],
        h4: ['Q', :black],
        e6: ['P', :black],
        a7: ['P', :black],
        b7: ['P', :black],
        c7: ['P', :black],
        d7: ['P', :black],
        f7: ['P', :black],
        g7: ['P', :black],
        h7: ['P', :black],
        a8: ['R', :black],
        b8: ['N', :black],
        c8: ['B', :black],
        e8: ['K', :black],
        f8: ['B', :black],
        g8: ['N', :black],
        h8: ['R', :black]
      }
    end

    let(:board) { Board.new(fools_squares) }

    let(:player) { Player.new }

    it 'returns true to checkmate?'
  end
end
