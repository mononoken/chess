# frozen_string_literal: true

class Movement
  attr_reader :origin, :boundaries, :step_directions, :step_limit

  def initialize(origin, boundaries, step_directions, step_limit)
    @origin = origin
    @boundaries = boundaries
    @step_directions = step_directions
    @step_limit = step_limit
  end

  def valid_destination?(destination)
    all_moves.any?(destination)
  end

  private

  def all_moves
    paths.flatten(1)
  end

  def paths
    step_directions.map { |step| path(origin, step) }
  end

  # Path is an array of positions in a given step direction.
  def path(position, step, steps = 0)
    next_position = next_position(position, step)

    return [] unless within_boundaries?(next_position) && within_step_limit?(steps)

    steps += 1
    [next_position] + path(next_position, step, steps)
  end

  def next_position(position, step)
    [position, step].transpose.map(&:sum)
  end

  def within_step_limit?(steps)
    return true if step_limit.nil?

    steps < step_limit
  end

  def within_boundaries?(position)
    boundaries[:files].include?(position[0]) && boundaries[:ranks].include?(position[1])
  end
end

class Piece
  def valid_destination?(origin, destination, boundaries)
    Movement.new(origin, boundaries, step_directions, step_limit).valid_destination?(destination)
  end

  private

  def step_directions
    raise "#{self.class} must implement #step_directions."
  end

  def step_limit
    raise "#{self.class} must implement #step_limit."
  end
end
