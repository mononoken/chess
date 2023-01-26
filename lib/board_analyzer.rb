# frozen_string_literal: true

require_relative './movement'

# Maybe rename to BoardStatus?
# Check for Board status in reference to the Chess game.
class BoardAnalyzer
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def check?(king)
    return false if king.nil?

    all_destinations(king.opponent_color).any?(board.piece_position(king))
  end

  def king(color)
    all_pieces(color).find(&:checkable?)
  end

  def move_will_create_check?(origin, destination, piece_color)
    hypothetical_board = board_after_hypothetical_move(origin, destination)

    hypothetical_analyzer = BoardAnalyzer.new(hypothetical_board)
    hypothetical_analyzer.check?(hypothetical_analyzer.king(piece_color))
  end

  def board_after_hypothetical_move(origin, destination)
    hypothetical_board = board.class.new(Marshal.load(Marshal.dump(board.files)))
    hypothetical_board.move(origin, destination)
    hypothetical_board
  end

  private

  def all_destinations(color, movement = Movement)
    all_pieces(color).map do |piece|
      movement.destinations(board.piece_position(piece), board)
    end.flatten(1).uniq
  end

  def all_pieces(color = nil)
    if color.nil?
      board.squares.map(&:content)
    else
      board.squares.map { |square| square.content if square.content&.color == color }
    end.compact
  end
end
