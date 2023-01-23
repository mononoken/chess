# frozen_string_literal: true

require_relative './../../lib/chess'
require_relative './../../lib/pieces/bishop'
require_relative './../../lib/pieces/king'
require_relative './../../lib/pieces/knight'
require_relative './../../lib/pieces/queen'
require_relative './../../lib/pieces/rook'

RSpec.describe 'Checkmate Game API' do
  let(:game) { Chess.new(board:, player:) }

  let(:board) { Board.new }

  let(:player) { Player.new }

  let(:white_king) { King.new(:white) }
  let(:white_rook) { Rook.new(:white) }

  let(:black_rook) { Rook.new(:black) }
end
