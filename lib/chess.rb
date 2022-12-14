# frozen_string_literal: true

require_relative './board'
require_relative './player'
require_relative './turn'

# Sends player movements to board until the game is over.
class Chess
  attr_reader :board, :player

  def initialize(board:, player:)
    @board = board
    @player = player
  end

  def play(turn = Turn)
    turn.run(board, player) until game_over?
  end

  def game_over?
    player.checkmate? || player.stalemate?
  end
end
