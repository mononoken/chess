# frozen_string_literal: true

# List valid destination positions in one direction on a board for an origin (with a piece).
class Path
  def self.positions(origin:, board:, step:)
    new(origin:, board:).positions(step:)
  end

  attr_reader :origin, :board

  def initialize(origin:, board:)
    @origin = origin
    @board = board
  end

  def positions(step:, position: origin, steps: 0)
    next_position = next_position(position, step)

    if valid_move?(next_position) && within_step_limit?(steps)
      steps += 1
      [next_position] + positions(step:, position: next_position, steps:)
    elsif valid_take?(next_position) && within_step_limit?(steps)
      [next_position]
    else
      []
    end
  end

  private

  def next_position(position, step)
    [position, step].transpose.map(&:sum)
  end

  def valid_move?(position)
    within_positions?(position) && unoccupied_position?(position)
  end

  def valid_take?(position)
    board.occupied_positions.any?(position) && board.piece(position).color != piece.color
  end

  def valid_position?(position)
    within_positions?(position) && board.occupied_positions.none?(position)
  end

  def within_step_limit?(steps)
    return true if step_limit.nil?

    steps < step_limit
  end

  def unoccupied_position?(position)
    board.occupied_positions.none?(position)
  end

  def within_positions?(position)
    all_positions.any?(position)
  end

  def all_positions
    @all_positions ||= board.positions
  end

  def step_directions
    piece.step_directions
  end

  def step_limit
    piece.step_limit
  end

  def piece
    @piece ||= board.piece(origin)
  end
end