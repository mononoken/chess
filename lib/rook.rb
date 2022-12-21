# frozen_string_literal: true

class Rook
  def valid_destination?(origin, destination, boundaries)
    movement(origin, boundaries).any?(destination)
  end

  private

  def movement(origin, boundaries)
    paths(origin, boundaries).flatten(1)
  end

  def paths(origin, boundaries)
    [
      top_vertical(origin, boundaries),
      bot_vertical(origin, boundaries),
      left_horizontal(origin, boundaries),
      right_horizontal(origin, boundaries)
    ]
  end

  def top_vertical(origin, boundaries)
    path(origin, [0, 1], boundaries, 0, nil)
  end

  def bot_vertical(origin, boundaries)
    path(origin, [0, -1], boundaries, 0, nil)
  end

  def left_horizontal(origin, boundaries)
    path(origin, [-1, 0], boundaries, 0, nil)
  end

  def right_horizontal(origin, boundaries)
    path(origin, [1, 0], boundaries, 0, nil)
  end

  def path(coord, step, boundaries, steps, step_limit)
    next_coord = coord_step(coord, step)

    return [] unless within_boundaries?(next_coord, boundaries) && within_step_limit?(steps, step_limit)

    steps += 1
    [next_coord] + path(next_coord, step, boundaries, steps, step_limit)
  end

  def coord_step(coord, step)
    [coord, step].transpose.map(&:sum)
  end

  def within_step_limit?(steps, step_limit)
    return true if step_limit.nil?

    steps < step_limit
  end

  def within_boundaries?(coordinates, boundaries)
    boundaries[:files].include?(coordinates[0]) && boundaries[:ranks].include?(coordinates[1])
  end
end
