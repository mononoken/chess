# frozen_string_literal: true

class Piece
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
end
