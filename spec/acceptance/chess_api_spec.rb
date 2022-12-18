# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe 'Solo Rook API' do
  xit 'only accepts valid rook moves' do
    board = Board.new

    player = Player.new

    game = Chess.new(board:, player:)

    rook = Rook.new

    origin = [4, 2]

    board.populate(rook, origin)

    invalid_destination = [5, 5]

    expect { game.play(player, origin, invalid_destination) }.to raise_error

    valid_destination = [4, 4]

    expect { game.play(player, origin, valid_destination) }.not_to raise_error
  end

  it 'moves rook across board' do
    board = Board.new

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
