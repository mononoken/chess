# frozen_string_literal: true

class King
  def valid_destination?(origin, destination, boundaries)
    movement(origin, boundaries).any?(destination)
  end

  private

  def movement(origin, boundaries)
    paths(origin, boundaries)
  end

  def paths(origin, boundaries)
    all_steps.map do |step|
      coord_step(origin, step)
    end.filter { |coordinates| within_boundaries?(coordinates, boundaries) }
  end

  def all_steps
    [[1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]]
  end

  def coord_step(coord, step)
    [coord, step].transpose.map(&:sum)
  end

  def within_boundaries?(coordinates, boundaries)
    boundaries[:files].include?(coordinates[0]) && boundaries[:ranks].include?(coordinates[1])
  end
end
