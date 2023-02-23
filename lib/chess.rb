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
    run_round until game_over?
  end

  def game_over?
    board.checkmate?(players.current)
  end

  def run_round
    puts board
    puts "#{players.current.capitalize}'s turn."
    send_move(player_movement)
    players.swap
  end

  def send_move(movement)
    # This clause may not belong here.
    raise InvalidDestinationError unless movement.destination.valid_destination?(movement.origin, board)

    board.process_movement(movement)
  end

  private

  def player_movement
    build_movement(origin = player_origin, player_destination(origin))
  end

  def build_movement(origin, destination, movement = Movement)
    movement.new(board:, origin:, destination:)
  end

  def player_origin
    puts 'Enter origin using algebraic coordinates (e.g. d2)'
    loop do
      input = gets.chomp
      origin = board.positions.position(input.to_sym)

      return origin if origin.valid_origin?(players.current, board)

      puts 'Invalid origin! Please enter a valid origin:'
    end
  end

  def player_destination(origin)
    puts 'Enter destination using algebraic coordinates (e.g. d4)'
    loop do
      input = gets.chomp
      destination = board.positions.position(input.to_sym)

      return destination if destination.valid_destination?(origin, board)

      puts 'Invalid destination! Please enter a valid destination:'
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
