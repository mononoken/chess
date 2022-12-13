# frozen_string_literal: true

require_relative './movement'

class Board
  attr_reader :squares

  def initialize(width: 8, height: 8)
    @squares = Array.new(width) { Array.new(height) }
  end

  def move(origin, destination)
    content = origin.empty

    destination.fill(content) unless content.nil?
  end
end
