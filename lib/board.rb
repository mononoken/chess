# frozen_string_literal: true

require_relative './square'


class Board
  class EmptyOriginError < StandardError
    def message
      'Move sent to an empty origin.'
    end
  end

  attr_reader :squares

  def initialize(squares = Array.new(8) { Array.new(8) { Square.new } })
    @squares = squares
  end

  def move(origin, destination)
    raise EmptyOriginError if square(origin).empty?

    content = square(origin).empty

    square(destination).fill(content)
  end

  def valid_destination?(origin, destination)
    square(origin).content.valid_destination?(origin, destination, boundaries)
  end

  def populate(piece, position)
    square(position).fill(piece)
  end

  private

  def boundaries
    {
      files: files_boundaries,
      ranks: ranks_boundaries
    }
  end

  def files_boundaries
    (0..squares.count - 1)
  end

  def ranks_boundaries
    (0..squares.reduce(squares[0].count) { |count, rank| [count, rank.count].min } - 1)
  end

  def square(position)
    squares[position[0]][position[1]]
  end
end
