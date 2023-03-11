# frozen_string_literal: true

require_relative './path'
require_relative './position'
require_relative './castling'

require 'pry-byebug'

# List all valid destination positions on a board for an origin (with a piece).
# Note that in this project 'movement' is used as a noun and 'move' as a verb.
class Movement
  def self.valid_destination?(destination, origin, board)
    new(origin:, board:).valid_destination?(destination)
  end

  def self.valid_destinations(origin, board)
    new(origin:, board:).valid_destinations
  end

  # This appears to be broken
  def self.paths_positions(origin, board)
    new(origin:, board:).paths_positions
  end

  include Castling

  attr_reader :board, :origin, :destination

  def initialize(board:, origin:, destination: NilPosition.new)
    @board = board
    @origin = origin
    @destination = destination
  end

  def promotion?
    piece.promotable? && piece.promotion_position?(destination)
  end

  # Returns true if the provided destination exists in #destinations.
  def valid_destination?(destination)
    if piece.castling_rights?
      valid_destinations.any?(destination) || valid_castling_positions(piece, board).any?(destination)
    else
      valid_destinations.any?(destination)
    end
  end

  # Array of valid move destination positions for the piece of the origin.
  # Conditional should be removable here, right?
  def valid_destinations
    filter_checks_own_king_positions(paths_positions)
  end

  def paths_positions
    paths_to_positions(destination_paths)
  end

  private

  def destination_paths
    paths + take_paths
  end

  def take_paths(path = Path)
    take_directions.map { |step| path.take_positions(origin:, board:, step:) }
  end

  def take_directions
    piece.take_directions
  end

  def paths_to_positions(paths)
    paths.flatten(1)
  end

  # step_directions is failing because steps are arrays
  def paths(directions = step_directions, path_class = Path)
    directions.map { |step| path_class.positions(origin:, board:, step:) }
  end

  # Problem here with :black player auto checkmate
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
        attacked_positions + self.class.valid_destinations(position, board)
      end.uniq
    end
  end

  def step_directions
    piece.step_directions
  end

  def piece
    @piece ||= origin.piece
  end
end
