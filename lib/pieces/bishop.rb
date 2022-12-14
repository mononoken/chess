# frozen_string_literal: true

require_relative './piece'

class Bishop < Piece
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
