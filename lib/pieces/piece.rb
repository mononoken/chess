# frozen_string_literal: true

require_relative ".././colorable_string"
require_relative "../en_passant"

# Store start positions with their matching color.
StartPosition = Struct.new(:position, :algebraic, :color, keyword_init: true)

class NilPiece < NilObject
  def to_s
    " "
  end
end

# Pieces for chess that store piece move behavior.
class Piece
  using ColorableString

  def self.start_positions
    []
  end

  attr_reader :color

  def initialize(color = nil)
    @color = color
    @first_move_taken = false
  end

  def castling_rights?
    false
  end

  def promotable?
    false
  end

  def first_move_taken?
    first_move_taken
  end

  def take_first_move
    # first_move_taken? = true
    self.first_move_taken = true
  end

  def take_directions
    []
  end

  def take_directions?
    take_directions.any?
  end

  def step_directions
    raise "#{self.class} must implement #step_directions."
  end

  def step_take?
    true
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

  def algebraic
    raise "#{self.class} must implement #algebraic."
  end

  def skin
    raise "#{self.class} must implement #skin."
  end

  def to_s
    skin.fg_color(color)
  end

  def post_initialize
  end

  private

  attr_accessor :first_move_taken
end
