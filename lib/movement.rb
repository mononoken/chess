# frozen_string_literal: true

require_relative './path'

# List all valid destination positions on a board for an origin (with a piece).
class Movement
  def self.valid_destination?(destination, origin, board)
    new(origin, board).valid_destination?(destination)
  end

  def self.destinations(origin, board)
    new(origin, board).destinations
  end

  attr_reader :origin, :board

  def initialize(origin, board)
    @origin = origin
    @board = board
  end

  def valid_destination?(destination)
    destinations.any?(destination)
  end

  def destinations
    if piece.checkable?
      paths.flatten(1) - positions_under_attack(piece.opponent_color)
    else
      filter_checks_own_king_positions(paths.flatten(1))
    end
  end

  private

  def filter_checks_own_king_positions(positions)
    positions.filter { |position| !board.movement_checks_own_king?(origin, position) }
  end

  def paths(path = Path)
    step_directions.map { |step| path.positions(origin:, board:, step:) }
  end

  def positions_under_attack(color)
    if color.nil?
      []
      # This is a bandaid. nil should actually give all attacks.
    else
      board.occupied_positions(color).reduce([]) do |attacked_positions, position|
        attacked_positions + Movement.destinations(position, board)
      end.uniq
    end
  end

  def step_directions
    piece.step_directions
  end

  def piece
    # Consider raising error if piece is nil. EmptyOriginError
    @piece ||= board.piece(origin)
  end
end
