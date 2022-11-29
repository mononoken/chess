# frozen_string_literal: true

# Display board of squares with pieces.
class Board
  attr_reader :squares

  def initialize(squares:)
    @squares = squares
  end

  # from bishop_spec
  def valid_coords
    # foo
  end

  def moves(position)
    squares.moves(position)
  end

  def simple_display
    "Board simple display:\n#{squares.simple_display}"
  end
end
