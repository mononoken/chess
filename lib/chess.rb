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

  # Broken
  def query_move
    loop do
      move = pick_move
      break move if valid_move?(move)
    end
  end

  def pick_move
    Move.new(gets_player_origin,
             gets_player_destination)
  end

  def valid_move?(origin = nil, destination = nil)
    true
  end

  def valid_origin?(origin)

  end

  def valid_destination?(destination)

  end

  private

  def gets_player_origin
    puts 'Player input origin:'
    gets.chomp.downcase.to_sym
  end

  def gets_player_destination
    puts 'Player input destination:'
    gets.chomp.downcase.to_sym
  end
end
