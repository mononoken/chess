# frozen_string_literal: true

require_relative "./piece"

class King < Piece
  def self.start_positions
    [
      StartPosition.new(position: [4, 0], algebraic: :e1, color: :white),
      StartPosition.new(position: [4, 7], algebraic: :e8, color: :black)
    ]
  end

  def castling_rights?
    !first_move_taken?
  end

  def self.algebraic
    :K
  end

  def step_directions
    [[1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]]
  end

  def step_limit
    1
  end

  def checkable?
    true
  end

  def skin
    "\u265A"
  end
end
