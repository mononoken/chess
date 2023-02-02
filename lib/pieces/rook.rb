# frozen_string_literal: true

require_relative './piece'

class Rook < Piece
  def self.start_positions
    [
      StartPosition.new(position: [0, 0], color: :white),
      StartPosition.new(position: [7, 0], color: :white),
      StartPosition.new(position: [0, 7], color: :black),
      StartPosition.new(position: [7, 7], color: :black)
    ]
  end

  def step_directions
    [[0, 1], [0, -1], [-1, 0], [1, 0]]
  end

  def step_limit
    nil
  end

  def skin
    case color
    when :white
      "\u2656"
    when :black
      "\u265C"
    else
      'R'
    end
  end
end
