# frozen_string_literal: true

class Movement
  def self.valid_destination?(destination, origin, board)
    new(origin, board).valid_destination?(destination)
  end

  # def self.destinations(origin, board)
  #   new(origin, board).destinations
  # end

  attr_reader :origin, :board

  def initialize(origin, board)
    @origin = origin
    @board = board
  end

  def valid_destination?(destination)
    destinations.any?(destination)
  end

  private

  # This should be public
  def destinations
    # filter_check_moves(paths.flatten(1) - board.occupied_positions(piece.color))
    paths.flatten(1)
  end

  # def player_destinations(player_color)
  #   board.occupied_positions(player_color).map do |position|
  #     movement.destinations(position, board)
  #   end
  # end

  # def filter_check_moves(destinations)
  #   destinations.filter do |destination|
  #     board.occupied_squares(:opponent_color).any? { |square| new(square, board).valid_destination?(board.position(destination)) }
  #   end
  # end

  def paths(path = Path)
    step_directions.map { |step| path.positions(origin:, board:, step:) }
  end

  def step_directions
    piece.step_directions
  end

  def piece
    board.piece(origin)
  end
end

class Path
  def self.positions(origin:, board:, step:)
    new(origin:, board:).positions(step:)
  end

  attr_reader :origin, :board

  def initialize(origin:, board:)
    @origin = Position.new(origin)
    @board = board
  end

  def positions(step:, position: origin, steps: 0)
    return [] unless valid_position?(position.next_coordinates(step)) && within_step_limit?(steps)

    steps += 1
    [position.next_coordinates(step)] + positions(step:, position: position.next(step), steps:)
  end

  private

  def valid_position?(position)
    within_boundaries?(position) && board.occupied_positions.none?(position)
  end

  def within_step_limit?(steps)
    return true if step_limit.nil?

    steps < step_limit
  end

  def within_boundaries?(position)
    boundaries[:files].include?(position[0]) && boundaries[:ranks].include?(position[1])
  end

  def boundaries
    board.boundaries
  end

  def step_directions
    piece.step_directions
  end

  def step_limit
    piece.step_limit
  end

  def piece
    board.piece(origin.coordinates)
  end
end

class Position
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
  end

  def next(step)
    Position.new([coordinates, step].transpose.map(&:sum))
  end

  def next_coordinates(step)
    self.next(step).coordinates
  end
end
