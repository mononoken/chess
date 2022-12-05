# frozen_string_literal: true

require_relative './board'
require_relative './move'

# Runs rounds until the game is over.
class Chess
  attr_reader :board

  def initialize(board: Board.new)
    @board = board
  end

  def play
    loop do
      run_round

      break if game_over?
    end
  end

  def game_over?
    # Pending check and checkmate implementation
  end

  def run_round(move = query_move)
    execute_move(move)
  end

  # private

  def execute_move(move)
    board.execute_move(move)
  end

  def query_move
    Move.new(origin: query_origin, destination: query_destination)
  end

  def query_origin
    loop do
      origin = pick_origin
      break origin if valid_origin?(origin)
    end
  end

  def valid_origin?(origin)
    # foo
  end

  def pick_origin
    # foo
  end

  def query_destination
    loop do
      destination = pick_destination
      break destination if valid_destination?(destination)
    end
  end

  def valid_destination?(destination)
    # foo
  end

  def pick_destination
    # foo
  end
end
