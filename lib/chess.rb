# frozen_string_literal: true

require_relative './board'
require_relative './player'
require_relative './movement'

# Runs game of chess until end condition is met.
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
    # @players = players
    @movement = movement
  end

  def play(player, origin, destination)
    raise InvalidDestinationError unless movement.valid_destination?(destination, origin, board)

    board.move(origin, destination)
  end

  private

  def white_king
    @white_king ||= board.all_pieces.find { |piece| piece.checkable? && piece.color == :white }
  end

  def black_king
    @black_king ||= board.all_pieces.find { |piece| piece.checkable? && piece.color == :black }
  end

  
end
