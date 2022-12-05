# frozen_string_literal: true

require_relative './board'
require_relative './move'

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

  def run_round
    execute_move(query_move)
  end

  def execute_move(move)
    board.execute_move(move)
  end

  def query_move
    loop do
      move = pick_move
      break move if valid_move?(move)
    end
  end

  def valid_move?(move)
    move.valid?
  end

  def pick_move
    
  end
end
