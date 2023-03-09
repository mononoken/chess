# frozen_string_literal: true

# List valid destination positions in one direction on a board for an origin (with a piece).
class Path
  def self.positions(origin:, board:, step:)
    new(origin:, board:).positions(step:)
  end

  def self.take_positions(origin:, board:, step:)
    new(origin:, board:).take_positions(step:)
  end

  attr_reader :board, :origin

  def initialize(board:, origin:)
    @board = board
    @origin = origin
  end

  # Return an array of Position objects based on step using recursion.
  def positions(step:, position: origin, steps: 0)
    return [] unless within_step_limit?(steps)

    next_position = position.step(step, board)

    if valid_move?(next_position)
      steps += 1
      [next_position] + positions(step:, position: next_position, steps:)
    elsif valid_take?(next_position) && piece.step_take?
      [next_position]
    else
      []
    end
  end

  def take_positions(step:, position: origin, steps: 0)
    positions(step:, position:, steps:).filter do |a_position|
      a_position.piece_color?(piece.opponent_color)
    end
  end

  private

  # This method should be renamed.
  def valid_take?(position)
    # empty check should not be necessary
    !position.empty? && position.piece_color?(piece.opponent_color)
  end

  def valid_move?(position)
    within_positions?(position) && position.empty?
  end

  def within_step_limit?(steps)
    return true if step_limit.nil?

    steps < step_limit
  end

  def within_positions?(position)
    all_positions.any?(position)
  end

  def all_positions
    @all_positions ||= board.positions
  end

  def step_limit
    piece.step_limit
  end

  def piece
    @piece ||= origin.piece
  end
end
