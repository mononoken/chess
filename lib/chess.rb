# frozen_string_literal: true

require_relative './board'
require_relative './pieces/pieces'
require_relative './movement'
require_relative './players'

# Runs game of chess until end condition is met.
class Chess
  class InvalidOriginError < StandardError
    def message
      'Invalid origin selected.'
    end
  end

  class InvalidDestinationError < StandardError
    def message
      'Invalid destination selected.'
    end
  end

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

  def valid_origin?(origin, player_color)
    valid_algebraic?(origin) && valid_color?(origin, player_color) && destinations?(origin, board)
  end

  def destinations?(origin, board)
    movement.valid_destinations(origin, board).any?
  end

  def valid_color?(origin, player_color)
    board.piece(origin)&.color == player_color
  end

  def valid_algebraic?(origin)
    board.positions_algebraic.any?(origin.algebraic)
  end

  def player_origin
    loop do
      puts 'Enter origin'
      input = gets.chomp
      origin = Position.from_algebraic(input)

      return origin if valid_origin?(origin, players.current)
    end
  end

  def player_destination(origin)
    loop do
      puts 'Enter destination'
      input = gets.chomp
      destination = Position.from_algebraic(input)

      return destination if valid_destination?(destination, origin, board)
    end
  end
end
