# frozen_string_literal: true

require_relative './piece'

class Knight < Piece
  def self.start_positions
    [
      StartPosition.new(position: [1, 0], color: :white),
      StartPosition.new(position: [6, 0], color: :white),
      StartPosition.new(position: [1, 7], color: :black),
      StartPosition.new(position: [6, 7], color: :black)
    ]
  end

  def step_directions
    [[1, 2], [2, 1], [1, -2], [2, -1], [-1, -2], [-2, -1], [-1, 2], [-2, 1]]
  end

  def step_limit
    1
  end

  def skin
    case color
    when :white
      "\u2658"
    when :black
      "\u265E"
    else
      'N'
    end
  end
end
