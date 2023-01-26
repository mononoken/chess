# frozen_string_literal: true

require_relative './piece'

class Pawn < Piece
  def step_directions
    [[0, 1]]
  end

  def step_limit
    1
  end

  def start_positions
    [
      StartPosition.new(position: [0, 1], color: :white),
      StartPosition.new(position: [1, 1], color: :white),
      StartPosition.new(position: [2, 1], color: :white),
      StartPosition.new(position: [3, 1], color: :white),
      StartPosition.new(position: [4, 1], color: :white),
      StartPosition.new(position: [5, 1], color: :white),
      StartPosition.new(position: [6, 1], color: :white),
      StartPosition.new(position: [7, 1], color: :white),
      StartPosition.new(position: [0, 7], color: :black),
      StartPosition.new(position: [1, 7], color: :black),
      StartPosition.new(position: [2, 7], color: :black),
      StartPosition.new(position: [3, 7], color: :black),
      StartPosition.new(position: [4, 7], color: :black),
      StartPosition.new(position: [5, 7], color: :black),
      StartPosition.new(position: [6, 7], color: :black),
      StartPosition.new(position: [7, 7], color: :black)
    ]
  end

  def to_s
    'P'
  end
end
