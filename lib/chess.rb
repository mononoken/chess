# frozen_string_literal: true

require_relative './board'
require_relative './pieces/pieces'
require_relative './movement'

# Runs game of chess until end condition is met.
class Chess
  class InvalidDestinationError < StandardError
    def message
      'Invalid destination selected.'
    end
  end

  attr_reader :board, :movement

  def initialize(board: Board.new(piece_types: Pieces.piece_types), movement: Movement)
    @board = board
    @movement = movement
    # Show instructions
  end

  # def play
  #   # rounds
  #   # announce result
  # end

  # def rounds
  #   round until game_over?
  # end

  # def game_over?
  #   board.checkmate?(:white) || board.checkmate?(:black)
  # end

  # def round
  #   # Set current player (this belongs in players I think)
  #   # And get valid_destination from current player
  #   # And send destination to board
  #   puts board
  #   puts 'Enter origin'
  #   origin = Position.from_algebra(gets.chomp.downcase.to_sym)
  #   puts 'Enter destination'
  #   destination = Position.from_algebra(gets.chomp.downcase.to_sym)

  #   make_move(origin, destination)
  # end

  def make_move(origin, destination)
    raise InvalidDestinationError unless movement.valid_destination?(destination, origin, board)

    board.move(origin, destination)
  end
end

# game = Chess.new
# game.play_rounds
