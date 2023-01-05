# frozen_string_literal: true

require_relative './square'

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

  def boundaries
    {
      files: files_boundaries,
      ranks: ranks_boundaries
    }
  end

  def occupied_positions(color = nil)
    occupied_squares(color).map { |square| position(square) }
  end

  def to_s
    <<~HEREDOC
      #{rank_spacer}
      #{rank_to_s(rank(7))}
      #{rank_spacer}
      #{rank_to_s(rank(6))}
      #{rank_spacer}
      #{rank_to_s(rank(5))}
      #{rank_spacer}
      #{rank_to_s(rank(4))}
      #{rank_spacer}
      #{rank_to_s(rank(3))}
      #{rank_spacer}
      #{rank_to_s(rank(2))}
      #{rank_spacer}
      #{rank_to_s(rank(1))}
      #{rank_spacer}
      #{rank_to_s(rank(0))}
      #{rank_spacer}
    HEREDOC
  end

  private

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

  def rank_spacer
    '+----+----+----+----+----+----+----+----+'
  end

  def rank_to_s(rank)
    rank.reduce(+'|') do |rank_s, square|
      rank_s << " #{square}  |"
    end
  end

  def rank(index)
    squares.map { |file| file[index] }
  end

  def files_boundaries
    (0..squares.count - 1)
  end

  def ranks_boundaries
    (0..squares.reduce(squares[0].count) { |count, rank| [count, rank.count].min } - 1)
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
