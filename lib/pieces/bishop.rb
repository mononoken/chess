# frozen_string_literal: true

require_relative './piece'

class Bishop < Piece
  def self.start_positions
    [
      StartPosition.new(position: [2, 0], color: :white),
      StartPosition.new(position: [5, 0], color: :white),
      StartPosition.new(position: [2, 7], color: :black),
      StartPosition.new(position: [5, 7], color: :black)
    ]
  end

  def step_directions
    [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end

  def step_limit
    nil
  end

  def to_s
    'B'
  end
end
