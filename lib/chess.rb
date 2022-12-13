# frozen_string_literal: true

require_relative './board'
require_relative './player'

# Sends player movements to board until the game is over.
class Chess
  attr_reader :board, :player

  def initialize(board:, player:)
    @board = board
    @player = player
  end

  def play
    board.move(player.movement) until game_over?
  end

  def game_over?
    player.checkmate? || player.stalemate?
  end
end
