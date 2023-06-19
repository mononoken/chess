# frozen_string_literal: true

require_relative "./piece"
require_relative "./pieces"
require_relative "../en_passant"
require_relative "../promotion"

class Pawn < Piece
  def self.start_positions
    [
      StartPosition.new(position: [0, 1], algebraic: :a2, color: :white),
      StartPosition.new(position: [1, 1], algebraic: :b2, color: :white),
      StartPosition.new(position: [2, 1], algebraic: :c2, color: :white),
      StartPosition.new(position: [3, 1], algebraic: :d2, color: :white),
      StartPosition.new(position: [4, 1], algebraic: :e2, color: :white),
      StartPosition.new(position: [5, 1], algebraic: :f2, color: :white),
      StartPosition.new(position: [6, 1], algebraic: :g2, color: :white),
      StartPosition.new(position: [7, 1], algebraic: :h2, color: :white),
      StartPosition.new(position: [0, 6], algebraic: :a7, color: :black),
      StartPosition.new(position: [1, 6], algebraic: :b7, color: :black),
      StartPosition.new(position: [2, 6], algebraic: :c7, color: :black),
      StartPosition.new(position: [3, 6], algebraic: :d7, color: :black),
      StartPosition.new(position: [4, 6], algebraic: :e7, color: :black),
      StartPosition.new(position: [5, 6], algebraic: :f7, color: :black),
      StartPosition.new(position: [6, 6], algebraic: :g7, color: :black),
      StartPosition.new(position: [7, 6], algebraic: :h7, color: :black)
    ]
  end

  def self.algebraic
    :P
  end

  include Promotion::Promotable
  include EnPassant::PassantVictim
  include EnPassant::Passanter

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

  def step_take?
    false
  end

  def step_limit
    first_move_taken? ? 1 : 2
  end

  def skin
    "\u265F"
  end
end
