# frozen_string_literal: true

require_relative './piece'

class Bishop < Piece
  
  private

  def paths(origin, boundaries)
    [
      top_right_diagonal(origin, boundaries),
      bot_right_diagonal(origin, boundaries),
      bot_left_diagonal(origin, boundaries),
      top_left_diagonal(origin, boundaries)
    ]
  end

  def top_right_diagonal(origin, boundaries)
    path(origin, [1, 1], boundaries, 0, nil)
  end

  def bot_right_diagonal(origin, boundaries)
    path(origin, [1, -1], boundaries, 0, nil)
  end

  def bot_left_diagonal(origin, boundaries)
    path(origin, [-1, -1], boundaries, 0, nil)
  end

  def top_left_diagonal(origin, boundaries)
    path(origin, [-1, 1], boundaries, 0, nil)
  end
end
