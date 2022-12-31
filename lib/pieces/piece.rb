# frozen_string_literal: true

class Piece
  def step_directions
    raise "#{self.class} must implement #step_directions."
  end

  def step_limit
    raise "#{self.class} must implement #step_limit."
  end
end
