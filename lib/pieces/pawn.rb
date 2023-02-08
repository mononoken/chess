# frozen_string_literal: true

require_relative './piece'

class Pawn < Piece
  def self.start_positions
    [
      StartPosition.new(position: [0, 1], color: :white),
      StartPosition.new(position: [1, 1], color: :white),
      StartPosition.new(position: [2, 1], color: :white),
      StartPosition.new(position: [3, 1], color: :white),
      StartPosition.new(position: [4, 1], color: :white),
      StartPosition.new(position: [5, 1], color: :white),
      StartPosition.new(position: [6, 1], color: :white),
      StartPosition.new(position: [7, 1], color: :white),
      StartPosition.new(position: [0, 6], color: :black),
      StartPosition.new(position: [1, 6], color: :black),
      StartPosition.new(position: [2, 6], color: :black),
      StartPosition.new(position: [3, 6], color: :black),
      StartPosition.new(position: [4, 6], color: :black),
      StartPosition.new(position: [5, 6], color: :black),
      StartPosition.new(position: [6, 6], color: :black),
      StartPosition.new(position: [7, 6], color: :black)
    ]
  end

  def take_directions
    case color
    when :white
      [[-1, 1], [1, 1]]
    when :black
      [[-1, -1], [1, -1]]
    end
  end

  def step_directions
    case color
    when :white
      [[0, 1]]
    when :black
      [[0, -1]]
    end
  end

  def special_first_step_directions
    case color
    when :white
      [[0, 2]]
    when :black
      [[0, -2]]
    end
  end

  def special_first_step_directions?
    true
  end

  def step_limit
    1
  end

  def skin
    "\u265F"
  end
end
