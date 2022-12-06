# frozen_string_literal: true

require_relative './board'
require_relative './move'

# Runs rounds until the game is over.
class Chess
  Player = Struct.new(:name, keyword_init: true)

  attr_reader :board

  def initialize(board: Board.new)
    @board = board
    @current_player = Player.new(name: 'player')
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
    Move.new(origin: verified_origin, destination: verified_destination)
  end

  Origin = Struct.new(:position, :board, :piece, :player, keyword_init: true)

  def verified_origin(player = current_player)
    loop do
      origin = origin_choice(player)
      break origin if valid_origin?(origin)
      # break origin if origin.valid?


    end
  end

  def origin_choice(player)
    Origin.new(
      position: position = verified_position(player),
      board: board,
      piece: board.position_piece(position),
      player: player
    )
  end

  # verified_position
  def verified_position(player)
    loop do
      position = origin_input(player).to_sym
      break position if valid_position?(position)

      # Raise invalid position error
    end
  end

  def valid_position?(position)
    board.valid_position(position)
  end

  def valid_origin?(origin)
    MoveChecker.valid_origin?(origin)
  end

  def origin_input(player)
    puts "#{player}, pick a piece to move by typing its position."
    player_input
  end

  def verified_destination(player = current_player)
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
    player_input
  end

  def player_input
    gets.chomp.downcase
  end
end
