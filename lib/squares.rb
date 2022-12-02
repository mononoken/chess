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

  def piece_color(color)
    squares.select { |square| square.piece_color == color }
  end

  # Rename find_position ?
  def find_square(position)
    squares.find { |square| square.position == position }
  end

  def simple_display
    squares.reduce('') do |display, square|
      "#{display}#{square.simple_display}\n"
    end
  end
end
