# frozen_string_literal: true

class Movement
  def self.valid_destination?(destination, origin, board)
    new(origin, board).valid_destination?(destination)
  end

  attr_reader :origin, :board

  def initialize(origin, board)
    @origin = origin
    @board = board
  end

  def valid_destination?(destination)
    destinations.any?(destination)
  end

  private

  def destinations
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

  def step_directions
    piece.step_directions
  end

  def step_limit
    piece.step_limit
  end

  def boundaries
    board.boundaries
  end

  def piece
    board.piece(origin)
  end
end
