# frozen_string_literal: true

require_relative './piece'

class Rook < Piece
  private

  def step_directions
    [[0, 1], [0, -1], [-1, 0], [1, 0]]
  end

  def step_limit
    nil
  end
end
