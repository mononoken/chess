# frozen_string_literal: true

require_relative './movement'

# Maybe rename to BoardStatus?
# Check for Board status in reference to the Chess game.
class BoardAnalyzer
  def self.check?(board, piece_color)
    new(board).check?(piece_color)
  end

  attr_reader :board

  def initialize(board)
    @board = board
  end

  def check?(piece_color)
    king = king(piece_color)
    return false if king.nil?

    all_destinations(king.opponent_color).any?(board.piece_position(king))
  end

  def king(color)
    all_pieces(color).find(&:checkable?)
  end

  def move_will_create_check?(origin, destination, piece_color)
    future_board = board.class.future_board(board, origin, destination)
    self.class.check?(future_board, piece_color)
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
