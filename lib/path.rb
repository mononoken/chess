# frozen_string_literal: true

require_relative './position'

require 'pry-byebug'

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

  # Return an array of Position objects based on step using recursion.
  def positions(step:, position: origin, steps: 0)
    next_position = next_position(position, step)

    if valid_move?(next_position) && within_step_limit?(steps)
      steps += 1
      [next_position] + positions(step:, position: next_position, steps:)
    elsif valid_take?(next_position) && within_step_limit?(steps) && piece.step_take?
      [next_position]
    elsif valid_take?(next_position) && within_step_limit?(steps) && piece.special_takes?
      piece.special_takes.filter_map do |step|
        next_position = next_position(position, step)

        [next_position] if valid_take?(next_position)
      end.flatten(1)
    else
      []
    end
  end

  private

  def next_position(position, step)
    position.step(step)
  end

  def valid_move?(position)
    within_positions?(position) && unoccupied_position?(position)
  end

  # This method should be renamed.
  def valid_take?(position)
    board.occupied_positions.any?(position) && board.piece(position)&.color == piece.opponent_color
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

  def step_limit
    piece.step_limit
  end

  def piece
    @piece ||= board.piece(origin)
  end
end
