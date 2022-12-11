# frozen_string_literal: true

# Display board of squares with pieces.
class Board
  attr_reader :squares

  def initialize(*squares)
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
    squares.reduce('') do |display, square|
      "#{display}#{square.simple_display}\n"
    end
  end
end

# Moving methods from Squares to Board
class Squares
  def position_exists?(position)
    positions.any?(position)
  end

  ###

  def moves(position)
    find_square(position).moves
  end

  # Bishop#moves spec
  def obstructed_coords(paths)
    # FIX_ME
  end

  # from bishop_spec
  def valid_coords
    # FIX_ME
  end

  def piece_color(color)
    squares.select { |square| square.piece_color == color }
  end

  # Rename find_position ?
  def find_square(position)
    squares.find { |square| square.position == position }
  end

  def valid_coords
    squares.reduce([]) do |unique_coord, square|
      unique_coord.concat(square.coordinates).uniq
    end
  end

  private

  def positions
    squares.map(&:position)
  end
end
