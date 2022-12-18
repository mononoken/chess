# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe 'Solo Rook API' do
  it 'moves rook across board' do
    grid = Array.new(8) { Array.new(8) { Square.new } }
    board = Board.new(grid)

    player = Player.new

    game = Chess.new(board:, player:)

    rook = Rook.new

    board.populate(rook, [0, 0])

    game.play(player, [0, 0], [0, 1])
    game.play(player, [0, 1], [0, 3])
    game.play(player, [0, 3], [0, 7])

    last_square = board.square([0, 7])

    expect(last_square.content).to eq(rook)
  end
end
