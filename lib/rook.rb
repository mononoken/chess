# frozen_string_literal: true

require_relative './piece'

class Rook < Piece
  private

  def paths(origin, boundaries)
    [
      top_vertical(origin, boundaries),
      bot_vertical(origin, boundaries),
      left_horizontal(origin, boundaries),
      right_horizontal(origin, boundaries)
    ]
  end

  def top_vertical(origin, boundaries)
    path(origin, [0, 1], boundaries, 0, nil)
  end

  def bot_vertical(origin, boundaries)
    path(origin, [0, -1], boundaries, 0, nil)
  end

  def left_horizontal(origin, boundaries)
    path(origin, [-1, 0], boundaries, 0, nil)
  end

  def right_horizontal(origin, boundaries)
    path(origin, [1, 0], boundaries, 0, nil)
  end
end
