# frozen_string_literal: true

require_relative './squares'

# Display board of squares with pieces.
class Board
  attr_reader :squares

  def initialize(squares:)
    @squares = squares
  end

  def moves(position)
    squares.moves(position)
  end

  def simple_display
    "Board simple display:\n#{squares.simple_display}"
  end
end
