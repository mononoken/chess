# frozen_string_literal: true

require_relative "./piece"

class Knight < Piece
  def self.start_positions
    [
      StartPosition.new(position: [1, 0], algebraic: :b1, color: :white),
      StartPosition.new(position: [6, 0], algebraic: :g1, color: :white),
      StartPosition.new(position: [1, 7], algebraic: :b8, color: :black),
      StartPosition.new(position: [6, 7], algebraic: :g8, color: :black)
    ]
  end

  def self.algebraic
    :N
  end

  def step_directions
    [[1, 2], [2, 1], [1, -2], [2, -1], [-1, -2], [-2, -1], [-1, 2], [-2, 1]]
  end

  def step_limit
    1
  end

  def skin
    "\u265E"
  end
end
