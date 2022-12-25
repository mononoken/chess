# frozen_string_literal: true

require_relative './movement'

class Piece
  attr_reader :movement

  def initialize(movement: Movement)
    @movement = movement
  end

  def valid_destination?(origin, destination, boundaries)
    # movement.valid_destination?(destination, origin, self)
    movement.valid_destination?(origin, destination, boundaries, step_directions, step_limit)
  end

  def step_directions
    raise "#{self.class} must implement #step_directions."
  end

  def step_limit
    raise "#{self.class} must implement #step_limit."
  end
end
