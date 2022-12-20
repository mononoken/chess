# frozen_string_literal: true

require_relative './board'
require_relative './player'

# Sends run to turn until the game is over.
class Chess
  class InvalidDestinationError < StandardError
    def message
      'Invalid destination selected.'
    end
  end

  attr_reader :board, :player

  def initialize(board:, player:)
    @board = board
    @player = player
  end

  def play(player, origin, destination)
    raise InvalidDestinationError unless board.valid_destination?(origin, destination)

    board.move(origin, destination)
  end

  private

  def valid_destination?(piece, destination)
    piece.valid_destination?(destination)
  end
end
