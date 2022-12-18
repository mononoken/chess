# frozen_string_literal: true

require_relative './board'
require_relative './player'
require_relative './turn'

# Sends run to turn until the game is over.
class Chess
  attr_reader :board, :player

  def initialize(board:, player:)
    @board = board
    @player = player
  end

  def play(player, origin, destination)
    board.move(origin, destination)
  end
end
