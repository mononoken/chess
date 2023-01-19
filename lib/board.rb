# frozen_string_literal: true

require_relative './square'
require_relative './movement'

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

  def all_attacks(color, movement = Movement)
    all_pieces(color).map { |piece| movement.destinations(piece_position(piece), self) }.flatten.uniq
  end

  def all_pieces(color = nil)
    if color.nil?
      squares.flatten.map(&:content)
    else
      squares.flatten.map{ |square| square.content if square.content.color == color }
    end
  end

  private

  def checks?(king)
    # all_attacks(opposite king color).any?(piece_position(king))
  end

  # def white_king
  #   @white_king ||= all_pieces.find { |piece| piece.checkable? && piece.color == :white }
  # end

  # def black_king
  #   @black_king ||= all_pieces.find { |piece| piece.checkable? && piece.color == :black }
  # end

  def default_squares
    Array.new(8) { Array.new(8) { Square.new } }
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
end
