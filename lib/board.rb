
require_relative './squares'

# Display board of squares with pieces.
class Board
  attr_reader :squares

  def initialize(squares: Squares.new)
    @squares = squares
  end

  # From Origin specs. No Board tests!
  def square(position)
    squares.find_square(position)
  end

  # From Origin specs. No Board tests!
  def position_exists?(position)
    squares.position_exists?(position)
  end

  # From Chess#move spec
  def execute_move(move)
    # foo
  end

  # From Chess
  def valid_origin?(position, color)
    squares.valid_origin?(position, color)
  end

  # From Chess
  def valid_destination?(position, player_color)
    squares.valid_destination?(position, player_color)
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
