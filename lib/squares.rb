# frozen_string_literal: true

require_relative './square'

# Create Squares for Chess Board.
class Squares
  attr_reader :squares

  def initialize(squares: chess_squares)
    @squares = squares
  end

  def positions
    squares.map(&:position)
  end

  def coordinates
    squares.map(&:coordinate)
  end

  private

  def chess_squares
    grid_permutation(0, 7).map { |coordinate| Square.new(coordinate:) }
  end

  def grid_permutation(min, max)
    (min..max).to_a.repeated_permutation(2).to_a
  end
end
