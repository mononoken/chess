# frozen_string_literal: true

require_relative './board'
require_relative './player'
require_relative './movement'

# Sends run to turn until the game is over.
class Chess
  class InvalidDestinationError < StandardError
    def message
      'Invalid destination selected.'
    end
  end

  attr_reader :board, :player, :movement

  def initialize(board:, player:, movement: Movement)
    @board = board
    @player = player
    @movement = movement
  end

  def play(player, origin, destination)
    raise InvalidDestinationError unless movement.valid_destination?(destination, origin, board)

    board.move(origin, destination)
  end

  private

  def valid_destination?(piece, destination)
    piece.valid_destination?(destination)
  end
end
