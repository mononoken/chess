# frozen_string_literal: true

require_relative './piece'

class Pawn < Piece
  def step_directions
    [[0, 1]]
  end

  def step_limit
    1
  end

  def to_s
    'P'
  end
end
