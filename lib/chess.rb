# frozen_string_literal: true

require_relative "chess_errors"
require_relative "serializable"
require_relative "board"
require_relative "pieces/pieces"
require_relative "players"

# Runs game of chess until end condition is met.
class Chess
  include ChessErrors
  include Serializable

  attr_reader :board, :players

  def initialize(board: Board.new(piece_types: Pieces.piece_types), players: Players.new)
    @board = board
    @players = players
  end

  def game_over?
    board.checkmate?(players.current) || board.stalemate?(players.current)
  end

  def send_move(movement)
    raise InvalidDestinationError unless movement.destination.valid_destination?(movement.origin, board)

    movement.actions.each(&:call)
  end
end
