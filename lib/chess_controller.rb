# frozen_string_literal: true

require_relative "chess"
require_relative "movement"

# Chess CLI controller
class ChessController
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

  attr_reader :chess

  def initialize(chess)
    @chess = chess
  end

  def play
    run_rounds
    announce_results
  end

  def run_rounds
    run_round until chess.game_over?
  end

  def run_round
    clear_term
    puts board
    puts "#{players.current.capitalize}'s turn."

    chess.send_move(player_movement)

    players.swap
  end

  private

  def board
    chess.board
  end

  def players
    chess.players
  end

  def player_movement
    build_movement(origin = player_origin, player_destination(origin))
  end

  def build_movement(origin, destination)
    Movement.new(board:, origin:, destination:)
  end

  def player_origin
    puts "Enter origin using algebraic coordinates (e.g. d2)"
    puts "Or enter 's' to save game."
    loop do
      input = gets.chomp.downcase

      return chess.save_game if input == "s"

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
    clear_term
    puts board
    puts result
  end

  def result
    if board.checkmate?(players.current)
      checkmate_message
    elsif board.stalemate?(players.current)
      stalemate_message
    end
  end

  def checkmate_message
    "#{players.current.capitalize} is in checkmate. #{players.other.capitalize} wins!"
  end

  def stalemate_message
    "#{players.current.capitalize} is in stalemate. Draw!"
  end

  def clear_term
    system("clear") || system("cls")
  end
end
