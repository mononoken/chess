# frozen_string_literal: true

require_relative './board'
require_relative './player'
require_relative './movement'
require_relative './pieces/bishop'
require_relative './pieces/king'
require_relative './pieces/knight'
require_relative './pieces/pawn'
require_relative './pieces/queen'
require_relative './pieces/rook'

# Runs game of chess until end condition is met.
class Chess
  class InvalidDestinationError < StandardError
    def message
      'Invalid destination selected.'
    end
  end

  def self.chess_pieces
    [King, Queen, Bishop, Knight, Rook, Pawn]
  end

  attr_reader :board, :player, :movement

  def initialize(board:, player:, movement: Movement)
    @board = board
    @player = player
    # @players = players
    @movement = movement
  end

  def play(player, origin, destination)
    raise InvalidDestinationError unless movement.valid_destination?(destination, origin, board)

    board.move(origin, destination)
  end
end
