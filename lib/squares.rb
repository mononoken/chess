# frozen_string_literal: true

require_relative './square'
require_relative './piece'

# Create Squares for Chess Board.
class Squares
  attr_reader :squares

  def initialize(squares:)
    @squares = squares
  end

  

  # def chess_initialize
  #   initialize(squares: chess_squares)
  # end

  # # Demeter?
  # def piece(position)
  #   squares.find { |square| square.position == position }.content
  # end

  # def positions
  #   squares.map(&:position)
  # end

  # def coordinates
  #   squares.map(&:coordinate)
  # end

  # def colors
  #   squares.map(&:color)
  # end

  private

  # # lol
  # def chess_squares
  #   white_and_black = %i[white black]

  #   chess_coordinates.map do |coordinate|
  #     white_and_black.reverse!
  #     Square.new(coordinate:, color: white_and_black[0])
  #   end
  # end

  # def chess_coordinates
  #   grid_permutation(0, 7)
  # end

  # def grid_permutation(min, max)
  #   (min..max).to_a.repeated_permutation(2).to_a
  # end
end
