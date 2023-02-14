# frozen_string_literal: true

require_relative './chess_errors'
require_relative './board'
require_relative './pieces/pieces'
require_relative './movement'
require_relative './players'

# Runs game of chess until end condition is met.
class Chess
  include ChessErrors

  attr_reader :board, :movement, :players

  def initialize(board: Board.new(piece_types: Pieces.piece_types), movement: Movement, players: Players.new)
    @board = board
    @movement = movement
    @players = players
    # Show instructions
  end

  def run_rounds
    run_round until game_over?
  end

  def game_over?
    board.checkmate?(players.current)
  end

  def run_round
    puts board
    make_move(origin = player_origin, player_destination(origin))
    players.swap
  end

  def make_move(origin, destination)
    raise InvalidDestinationError unless movement.valid_destination?(destination, origin, board)

    board.move(origin, destination)
  end

  private

  def valid_destination?(destination, origin, board)
    movement.valid_destination?(destination, origin, board)
  end

  def player_origin
    loop do
      puts 'Enter origin'
      input = gets.chomp
      origin = board.positions.position(input.to_sym)

      return origin if origin.valid_origin?(players.current, board)
    end
  end

  def player_destination(origin)
    loop do
      puts 'Enter destination'
      input = gets.chomp
      destination = Position.from_algebraic(input)
      # destination = board.positions.position(input.to_sym)

      return destination if valid_destination?(destination, origin, board)
    end
  end
end
