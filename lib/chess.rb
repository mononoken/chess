# frozen_string_literal: true

require_relative './board'

Move = Struct.new(:origin, :destination)

class Chess
  attr_reader :board

  def initialize(board: Board.new)
    @board = board
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

  # Broken
  def query_move
    loop do
      move = pick_move
      break move if valid_move?(move)
    end
  end

  def pick_move
    Move.new(origin: gets_player_origin,
             destination: gets_player_destination)
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
