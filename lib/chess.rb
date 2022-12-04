# frozen_string_literal: true

require_relative './board'
require_relative './player'

Move = Struct.new(:origin, :destination)

class Chess
  attr_reader :board, :player

  def initialize(board: Board.new, player: Player.new)
    @board = board
    @player = player
  end

  # Dependency (as well as test)
  # Knows #query_move will return an array that needs to be splat
  # For #move to receive it
  def run_round
    execute_move(*query_move)
  end

  def execute_move(origin, destination)
    board.move(origin, destination)
  end

  def query_move
    pick_move(player)
  end

  def pick_move(player)

  end

  def valid_move?(origin, destination)
    true
  end

  def valid_origin?(origin)

  end

  def valid_destination?(destination)

  end
end
