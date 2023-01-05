# frozen_string_literal: true

require_relative './piece'

class Knight < Piece
  def step_directions
    [[1, 2], [2, 1], [1, -2], [2, -1], [-1, -2], [-2, -1], [-1, 2], [-2, 1]]
  end

  def step_limit
    1
  end

  def to_s
    'N'
  end
end
