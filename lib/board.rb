# frozen_string_literal: true

require_relative './square'
require_relative './movement'

class Board
  attr_reader :squares

  def initialize(squares = Array.new(8) { Array.new(8, Square.new) })
    @squares = squares
  end
end
