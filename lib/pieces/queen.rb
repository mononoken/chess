# frozen_string_literal: true

require_relative './piece'

class Queen < Piece
  def step_directions
    [[1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]]
  end

  def step_limit
    nil
  end
end
