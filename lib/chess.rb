# frozen_string_literal: true

require_relative './board'
require_relative './player'
require_relative './movement'
require_relative './position'
require_relative './pieces/pieces'

# Runs game of chess until end condition is met.
class Chess
  class InvalidDestinationError < StandardError
    def message
      'Invalid destination selected.'
    end
  end

  attr_reader :board, :player, :movement

  def initialize(board: Board.new, player: Player.new, pieces: Pieces, movement: Movement)
    @board = board
    @player = player
    # @players = players
    @movement = movement
  end

  def play_game
    # rounds
    # announce result
  end

  def play_rounds
    round until game_over?
  end

  def round
    # Set current player (this belongs in players I think)
    # And get valid_destination from current player
    # And send destination to board

    # play(player, gets.chomp.downcase.to_a, gets.chomp.downcase)
  end

  def play(player, origin, destination)
    raise InvalidDestinationError unless movement.valid_destination?(destination, origin, board)

    board.move(origin, destination)
  end
end
