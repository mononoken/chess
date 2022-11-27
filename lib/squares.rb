# frozen_string_literal: true

require_relative './square'

# Create Squares for Chess Board.
class Squares
  attr_reader :squares

  def initialize(*squares)
    @squares = squares
  end

  def simple_display
    squares.reduce('') do |display, square|
      "#{display}#{square.simple_display}\n"
    end
  end
end
