# frozen_string_literal: true

require_relative './piece'

class King < Piece
  def step_directions
    [[1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]]
  end

  def step_limit
    1
  end

  def checkable?
    true
  end

  def start_positions
    [
      StartPosition.new(position: [4, 0], color: :white),
      StartPosition.new(position: [4, 7], color: :black)
    ]
  end

  def to_s
    'K'
  end
end
