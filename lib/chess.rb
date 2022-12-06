# frozen_string_literal: true

require_relative './board'
require_relative './move'

# Runs rounds until the game is over.
class Chess
  attr_reader :board

  def initialize(board: Board.new)
    @board = board
    @current_player = 'Player'
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

  def execute_move(move)
    board.execute_move(move)
  end

  # private

  def query_move
    Move.new(origin: query_origin, destination: query_destination)
  end

  def query_origin(player = current_player)
    loop do
      origin = pick_origin(player)
      break origin if valid_origin?(origin, player)
    end
  end

  # player or player_color ?
  def valid_origin?(origin, player = current_player)
    board.valid_origin?(origin, player.color)
  end

  def pick_origin(player)
    puts "#{player}, pick a piece to move by typing its position."
    gets.chomp.downcase.to_sym
  end

  def query_destination(player = current_player)
    loop do
      destination = pick_destination(player)
      break destination if valid_destination?(destination, player)
    end
  end

  def valid_destination?(destination, player_color = current_player.color)
    board.valid_destination?(destination, player_color)
  end

  def pick_destination(player)
    puts "#{player}, pick where you want to move piece by typing the position."
    gets.chomp.downcase.to_sym
  end
end
