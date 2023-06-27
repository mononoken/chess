# frozen_string_literal: true

require_relative "./chess_errors"
require_relative "./board"
require_relative "./pieces/pieces"
require_relative "./players"
require_relative "./player_input"
require_relative "./movement"
require_relative "./serializable"

# Runs game of chess until end condition is met.
class Chess
  def self.instructions
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

  include ChessErrors
  include Serializable

  attr_reader :board, :players

  def initialize(board: Board.new(piece_types: Pieces.piece_types), players: Players.new)
    @board = board
    @players = players
  end

  def play
    run_rounds
    announce_results
  end

  def run_rounds
    run_round until game_over?
  end

  def game_over?
    board.checkmate?(players.current) || board.stalemate?(players.current)
  end

  def run_round
    puts board
    puts "#{players.current.capitalize}'s turn."
    send_move(player_movement)
    players.swap
  end

  def send_move(movement)
    raise InvalidDestinationError unless movement.destination.valid_destination?(movement.origin, board)

    movement.actions.each(&:call)
  end

  private

  # def player_movement
  #   build_movement(origin = player_origin, player_destination(origin))
  # end

  def player_movement
    build_movement(origin = PlayerInput.player_origin.input, PlayerInput.player_destination(origin, board))
  end

  def build_movement(origin, destination, movement_class = Movement)
    movement_class.new(board:, origin:, destination:)
  end

  def player_origin
    puts "Enter origin using algebraic coordinates (e.g. d2)"
    puts "Or enter 's' to save game."
    loop do
      input = gets.chomp.downcase

      return save_game if input == "s"

      origin = board.positions.position(input.to_sym)

      return origin if origin.valid_origin?(players.current, board)

      puts "Invalid origin! Please enter a valid origin:"
    end
  end

  def player_destination(origin)
    puts "Enter destination using algebraic coordinates (e.g. d4)"
    loop do
      input = gets.chomp
      destination = board.positions.position(input.to_sym)

      return destination if destination.valid_destination?(origin, board)

      puts "Invalid destination! Please enter a valid destination:"
    end
  end

  def announce_results
    puts board

    result = if board.checkmate?(players.current)
      checkmate_message
    elsif board.stalemate?(players.current)
      stalemate_message
    end

    puts result
  end

  def checkmate_message
    "#{players.current.capitalize} is in checkmate. #{players.other.capitalize} wins!"
  end

  def stalemate_message
    "#{players.current.capitalize} is in stalemate. Draw!"
  end
end
