# frozen_string_literal: true

require_relative './piece'

class King < Piece
  private

  def paths(origin, boundaries)
    all_steps.map { |step| path(origin, step, boundaries, 0, 1) }
  end

  def all_steps
    [[1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]]
  end
end
