# frozen_string_literal: true

require_relative '.././colorable_string'

# Store start positions with their matching color.
StartPosition = Struct.new(:position, :color, keyword_init: true)

# Pieces for chess that store piece move behavior.
class Piece
  using ColorableString

  def self.start_positions
    []
  end

  attr_reader :color

  def initialize(color = nil)
    @color = color
  end

  def take_directions
    step_directions
  end

  def step_directions
    raise "#{self.class} must implement #step_directions."
  end

  def special_first_step_directions
    []
  end

  def special_first_step_directions?
    false
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

  def bg_color
    # Set BG color of to_s per square color.
  end

  def skin
    raise "#{self.class} must implement #skin."
  end

  def to_s
    skin.fg_color(color)
  end

  def post_initialize; end
end
