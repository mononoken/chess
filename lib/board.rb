# frozen_string_literal: true

require_relative './square'
require_relative './movement'

# Chess board that stores and manipulates board data in a 2-D array.
class Board
  class EmptyOriginError < StandardError
    def message
      'Move sent to an empty origin.'
    end
  end

  attr_reader :squares

  def initialize(squares = default_squares)
    @squares = squares
  end

  def move(origin, destination)
    raise EmptyOriginError if square(origin).empty?

    content = square(origin).empty

    square(destination).fill(content)
  end

  def populate(piece, position)
    square(position).fill(piece)
  end

  def piece(position)
    square(position).content
  end

  def positions(squares = self.squares)
    squares.flatten.map { |square| position(square) }
  end

  def occupied_positions(color = nil)
    occupied_squares(color).map { |square| position(square) }
  end

  def to_s
    <<~HEREDOC
      +----+----+----+----+----+----+----+----+
      #{ranks.reverse.map { |rank| "#{rank_to_s(rank)}\n+----+----+----+----+----+----+----+----+\n" }.join.strip}
    HEREDOC
  end

  def check?(king)
    return false if king.nil?

    all_destinations(king.opponent_color).any?(piece_position(king))
  end

  def king(color)
    all_pieces.find { |piece| piece.checkable? && piece.color == color }
  end

  def move_will_create_check?(origin, destination, piece_color)
    hypothetical_board = board_after_hypothetical_move(origin, destination)

    hypothetical_board.check?(hypothetical_board.king(piece_color))
  end

  private

  def board_after_hypothetical_move(origin, destination)
    hypothetical_board = Board.new(Marshal.load(Marshal.dump(squares)))
    hypothetical_board.move(origin, destination)
    hypothetical_board
  end

  def all_destinations(color, movement = Movement)
    all_pieces(color).map do |piece|
      movement.destinations(piece_position(piece), self)
    end.flatten(1).uniq
  end

  def all_pieces(color = nil)
    if color.nil?
      squares.flatten.map(&:content)
    else
      squares.flatten.map { |square| square.content if square.content&.color == color }
    end.compact
  end

  def occupied_squares(color)
    if color.nil?
      squares.flatten.reject(&:empty?)
    else
      squares.flatten.select { |square| square.piece_color?(color) }
    end
  end

  def rank_to_s(rank)
    rank.reduce(+'|') do |rank_s, square|
      rank_s << " #{square}  |"
    end
  end

  def ranks
    ranks_boundaries.to_a.map { |index| rank(index) }
  end

  def rank(index)
    squares.map { |file| file[index] }
  end

  def ranks_boundaries
    (0..squares.reduce(squares[0].count) { |count, rank| [count, rank.count].min } - 1)
  end

  def piece_position(piece)
    position(squares.flatten.find { |square| square.content == piece })
  end

  def position(square)
    squares.map.with_index do |file, file_index|
      file.map.with_index do |board_square, rank_index|
        [file_index, rank_index] if board_square == square
      end
    end.flatten.compact
  end

  def square(position)
    squares[position[0]][position[1]]
  end

  def default_squares
    Array.new(8) { Array.new(8) { Square.new } }
  end
end
