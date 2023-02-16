# frozen_string_literal: true

require_relative './chess_errors'
require_relative './board'
require_relative './pieces/pieces'
require_relative './players'
require_relative './movement'

# Runs game of chess until end condition is met.
class Chess
  include ChessErrors

  attr_reader :board, :players

  def initialize(board: Board.new(piece_types: Pieces.piece_types), players: Players.new)
    @board = board
    @players = players
    puts instructions
  end

  def play
    run_rounds
    announce_results
  end

  def run_rounds
    new_run_round until game_over?
  end

  def game_over?
    board.checkmate?(players.current)
  end

  def new_run_round
    puts board
    new_send_move(build_movement)
    players.swap
  end

  def run_round
    puts board
    movement = build_movement
    send_move(movement.origin, movement.destination)
    players.swap
  end

  def build_movement(origin = player_origin, destination = player_destination(origin), movement = Movement)
    movement.new(origin, board, destination)
  end

  def new_send_move(movement)
    raise InvalidDestinationError unless movement.destination.valid_destination?(movement.origin, board)

    board.new_move(movement)
  end

  def send_move(origin, destination)
    raise InvalidDestinationError unless destination.valid_destination?(origin, board)

    board.move(origin, destination)
  end

  private

  def player_origin
    loop do
      puts 'Enter origin using algebraic coordinates (e.g. d2)'
      input = gets.chomp
      origin = board.positions.position(input.to_sym)

      return origin if origin.valid_origin?(players.current, board)
    end
  end

  def player_destination(origin)
    loop do
      puts 'Enter destination using algebraic coordinates (e.g. d4)'
      input = gets.chomp
      destination = board.positions.position(input.to_sym)

      return destination if destination.valid_destination?(origin, board)
    end
  end

  def announce_results
    puts board

    result = if board.checkmate?(:white)
               'White king is in checkmate. Black wins!'
             elsif board.checkmate?(:black)
               'Black king is in checkmate. White wins!'
             end
    puts result
  end

  def instructions
    <<~HEREDOC
      Welcome to Chess!
      This is a terminal chess game that two players can play together.
      Each player (starting with white) will pick the coordinate of a
      piece they would like to move, and then the coordinates they want
      to move the piece to.
      Coordinates are referenced using Chess algebraic notation.
      Refer to the grid labels for assistance.
    HEREDOC
  end
end
