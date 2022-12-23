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

  # Path is an array of coordinates in a given step direction.
  def path(coord, step, steps = 0)
    next_coord = coord_step(coord, step)

    return [] unless within_boundaries?(next_coord) && within_step_limit?(steps)

    steps += 1
    [next_coord] + path(next_coord, step, steps)
  end

  def coord_step(coord, step)
    [coord, step].transpose.map(&:sum)
  end

  def within_step_limit?(steps)
    return true if step_limit.nil?

    steps < step_limit
  end

  def within_boundaries?(coord)
    boundaries[:files].include?(coord[0]) && boundaries[:ranks].include?(coord[1])
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
