# frozen_string_literal: true

require_relative './movement'

class Board
  attr_reader :squares

  def initialize(squares = Array.new(8) { Array.new(8) })
    @squares = squares
  end

  def move(origin, destination)
    content = origin.empty

    destination.fill(content) unless content.nil?
  end
end
