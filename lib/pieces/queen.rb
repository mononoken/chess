# frozen_string_literal: true

require_relative './piece'

class Queen < Piece
  def self.start_positions
    [
      StartPosition.new(position: [3, 0], color: :white),
      StartPosition.new(position: [3, 7], color: :black)
    ]
  end

  def step_directions
    [[1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]]
  end

  def step_limit
    nil
  end

  def to_s
    'Q'
  end
end
