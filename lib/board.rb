# frozen_string_literal: true

# Display board of squares with pieces.
class Board
  attr_reader :squares

  def initialize(squares:)
    @squares = squares
  end

  def moves(position)
    squares.moves(position)
  end

  # Bishop#moves spec
  def obstructed_coords(paths)
    # FIX_ME
  end

  # from bishop_spec
  def valid_coords
    # FIX_ME
  end

  def simple_display
    "Board simple display:\n#{squares.simple_display}"
  end
end
