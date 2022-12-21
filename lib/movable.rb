# frozen_string_literal: true

module Movable
  def valid_destination?(origin, destination, boundaries)
    movement(origin, boundaries).any?(destination)
  end

  private

  def movement(origin, boundaries)
    paths(origin, boundaries).flatten(1)
  end

  def paths(origin, boundaries)
    []
  end

  def path(coord, step, boundaries)
    next_coord = coord_step(coord, step)

    return [] unless within_boundaries?(next_coord, boundaries)

    [next_coord] + path(next_coord, step, boundaries)
  end

  def coord_step(coord, step)
    [coord, step].transpose.map(&:sum)
  end

  def within_boundaries?(coordinates, boundaries)
    boundaries[:files].include?(coordinates[0]) && boundaries[:ranks].include?(coordinates[1])
  end
end
