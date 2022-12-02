# frozen_string_literal: true

require_relative './square'

# Manage all Square objects as an array.
class Squares
  attr_reader :squares

  def initialize(*squares)
    @squares = Array.new(squares)
  end

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

  def simple_display
    squares.reduce('') do |display, square|
      "#{display}#{square.simple_display}\n"
    end
  end
end
