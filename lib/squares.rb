# frozen_string_literal: true

require_relative './square'

# Manage all Square objects as an array.
class Squares
  attr_reader :squares

  def initialize(*squares)
    @squares = Array.new(squares)
  end

  # CONTINUE WORKING ON PRIVATE METHODS AND PUBLIC METHOD
  def valid_origin?(position, color)
    position_exists?(position) && matching_color?(color, piece_color(position))
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

  def simple_display
    squares.reduce('') do |display, square|
      "#{display}#{square.simple_display}\n"
    end
  end

  private

  def matching_color?(color1, color2)
    color1 == color2
  end

  # DEMETER
  def piece_color(position)
    squares.find { |square| square.position == position }.content.color
  end

  def position_exists?(position)
    positions.any?(position)
  end

  def positions
    squares.map(&:position)
  end
end
