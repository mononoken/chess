# frozen_string_literal: true

# Store start positions with their matching color.
StartPosition = Struct.new(:position, :color, keyword_init: true)

# Pieces for chess that store piece move behavior.
class Piece
  def self.start_positions
    []
  end

  def self.chess_pieces
    [King, Queen, Bishop, Knight, Rook, Pawn]
  end

  attr_reader :color

  def initialize(color = nil)
    @color = color
  end

  def step_directions
    raise "#{self.class} must implement #step_directions."
  end

  def step_limit
    raise "#{self.class} must implement #step_limit."
  end

  def checkable?
    false
  end

  def opponent_color
    case color
    when :black
      :white
    when :white
      :black
    end
  end

  def to_s
    raise "#{self.class} must implement #to_s."
  end
end
