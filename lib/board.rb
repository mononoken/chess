# frozen_string_literal: true

require_relative './square'
require_relative './movement'

class Board
  class EmptyOriginError < StandardError
    def message
      'Move sent to an empty origin.'
    end
  end

  attr_reader :files

  def initialize(files = default_files)
    @files = files
  end

  def move(origin, destination)
    raise EmptyOriginError if square(file: origin[0], rank: origin[1]).empty?

    content = square(file: origin[0], rank: origin[1]).empty

    square(file: destination[0], rank: destination[1]).fill(content)
  end

  def populate(piece, position)
    square(file: position[0], rank: position[1]).fill(piece)
  end

  def piece_position(piece)
    position(squares.find { |square| square.content == piece })
  end

  def piece(position)
    square(file: position[0], rank: position[1]).content
  end

  def positions(files = self.files)
    squares.map { |square| position(square) }
  end

  def occupied_positions(color = nil)
    occupied_squares(color).map { |square| position(square) }
  end

  def squares
    files.flatten
  end

  def to_s
    <<~HEREDOC
      +----+----+----+----+----+----+----+----+
      #{ranks.reverse.map { |rank| "#{rank_to_s(rank)}\n+----+----+----+----+----+----+----+----+\n" }.join.strip}
    HEREDOC
  end

  private

  def occupied_squares(color)
    if color.nil?
      squares.reject(&:empty?)
    else
      squares.select { |square| square.piece_color?(color) }
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
    files.map { |file| file[index] }
  end

  def ranks_boundaries
    (0..files.reduce(files[0].count) { |count, rank| [count, rank.count].min } - 1)
  end

  def position(square)
    files.map.with_index do |file, file_index|
      file.map.with_index do |board_square, rank_index|
        [file_index, rank_index] if board_square == square
      end
    end.flatten.compact
  end

  def square(file: nil, rank: nil)
    files[file][rank]
  end

  def default_files
    Array.new(8) { Array.new(8) { Square.new } }
  end
end
