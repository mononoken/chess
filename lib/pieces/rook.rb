# frozen_string_literal: true

require_relative './piece'

class Rook < Piece
  def self.start_positions
    [
      StartPosition.new(position: [0, 0], algebraic: :a1, color: :white),
      StartPosition.new(position: [7, 0], algebraic: :h1, color: :white),
      StartPosition.new(position: [0, 7], algebraic: :a8, color: :black),
      StartPosition.new(position: [7, 7], algebraic: :h8, color: :black)
    ]
  end

  def self.algebraic
    :R
  end

  def step_directions
    [[0, 1], [0, -1], [-1, 0], [1, 0]]
  end

  def step_limit
    nil
  end

  def skin
    "\u265C"
  end
end
