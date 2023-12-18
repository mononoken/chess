# frozen_string_literal: true

require_relative "piece"

class Bishop < Piece
  def self.start_positions
    [
      StartPosition.new(position: [2, 0], algebraic: :c1, color: :white),
      StartPosition.new(position: [5, 0], algebraic: :f1, color: :white),
      StartPosition.new(position: [2, 7], algebraic: :c8, color: :black),
      StartPosition.new(position: [5, 7], algebraic: :f8, color: :black)
    ]
  end

  def self.algebraic
    :B
  end

  def step_directions
    [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end

  def step_limit
    nil
  end

  def skin
    "\u265D"
  end
end
