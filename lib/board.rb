# frozen_string_literal: true

require_relative './square'

class Board
  attr_reader :squares

  def initialize(squares = Array.new(8) { Array.new(8) { Square.new } })
    @squares = squares
  end

  def move(origin, destination)
    return if square(origin).empty?

    content = square(origin).empty

    square(destination).fill(content)
  end

  def populate(piece, position)
    square(position).content = piece
  end

  def square(position)
    squares[position[0]][position[1]]
  end
end
