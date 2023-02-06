# frozen_string_literal: true

require_relative './path'

# List all valid destination positions on a board for an origin (with a piece).
# Note that in this project 'movement' is used as a noun and 'move' as a verb.
class Movement
  def self.valid_destination?(destination, origin, board)
    new(origin, board).valid_destination?(destination)
  end

  def self.valid_destinations(origin, board)
    new(origin, board).valid_destinations
  end

  def self.paths_positions(origin, board)
    new(origin, board).paths_positions
  end

  attr_reader :origin, :board

  def initialize(origin, board)
    @origin = origin
    @board = board
  end

  # Returns true if the provided destination exists in #destinations.
  def valid_destination?(destination)
    valid_destinations.any?(destination)
  end

  # Array of valid move destination positions for the piece of the origin.
  # Conditional should be removable here, right?
  def valid_destinations
    filter_checks_own_king_positions(paths_positions)
  end

  def paths_positions(paths = self.paths)
    paths_to_positions(paths)
  end

  # private

  def paths_to_positions(paths)
    paths.flatten(1)
  end

  def paths(path = Path)
    step_directions.map { |step| path.positions(origin:, board:, step:) }
  end

  def filter_checks_own_king_positions(positions)
    positions.filter { |position| !destination_checks_own_king?(position) }
  end

  def destination_checks_own_king?(destination)
    board.move_will_create_check?(origin, destination, piece.color)
  end

  def positions_under_attack(color)
    if color.nil?
      []
      # This is a bandaid. nil should actually give all attacks.
    else
      board.occupied_positions(color).reduce([]) do |attacked_positions, position|
        attacked_positions + Movement.valid_destinations(position, board)
      end.uniq
    end
  end

  def step_directions
    piece.step_directions
  end

  def piece
    # Should not have to query board for piece, as position.square.piece should return.
    @piece ||= board.piece(origin)
  end
end
