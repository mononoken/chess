# frozen_string_literal: true

require_relative "./path"
require_relative "./castling"
require_relative "./en_passant"
require_relative "./promotion"

# List all valid destination positions on a board for an origin (with a piece).
# Note that in this project 'movement' is used as a noun and 'move' as a verb.
class Movement
  def self.valid_destination?(destination, origin, board)
    new(origin:, board:).valid_destination?(destination)
  end

  def self.valid_destinations(origin, board)
    new(origin:, board:).valid_destinations
  end

  def self.paths_positions(origin, board)
    new(origin:, board:).paths_positions
  end

  # FIX_ME Messy implementation but for some reason subbing valid_destinations
  # for valid_destinations_for_origin was not working.
  def self.valid_destinations_for_origin(origin, board)
    new(origin:, board:).valid_destinations_for_origin
  end

  include Castling
  include EnPassant::PassantMovement
  include Promotion::Promoter

  attr_reader :board, :origin, :destination

  def initialize(board:, origin:, destination: NilPosition.new)
    @board = board
    @origin = origin
    @destination = destination
  end

  def actions
    @actions ||= default_actions.concat(special_actions)
  end

  # Returns true if the provided destination exists in #destinations.
  # def valid_destination?(destination)
  #   valid_destinations.any?(destination)
  # end

  def valid_destination?(destination)
    if piece.castling_rights?
      valid_destinations.any?(destination) || valid_castling_positions(piece, board).any?(destination)
    elsif passant_victim?
      valid_destinations.any?(destination) || valid_passant_destinations(piece, board).any?(destination)
    else
      valid_destinations.any?(destination)
    end
  end

  # Array of valid move destination positions for the piece of the origin.
  # def valid_destinations
  #   if piece.castling_rights?
  #     valid_castling_positions(piece, board)
  #   elsif passant_victim?
  #     valid_passant_destinations(piece, board)
  #   else
  #     []
  #   end.concat(filter_checks_own_king_positions(paths_positions))
  # end

  def valid_destinations
    filter_checks_own_king_positions(paths_positions)
  end

  def valid_destinations_for_origin
    if piece.castling_rights?
      valid_castling_positions(piece, board)
    elsif passant_victim?
      valid_passant_destinations(piece, board)
    else
      []
    end.concat(filter_checks_own_king_positions(paths_positions))
  end

  def paths_positions
    paths_to_positions(destination_paths)
  end

  private

  def default_actions
    move_action = -> { board.move(self) }

    [move_action]
  end

  def special_actions
    special_actions = []

    special_actions.push(castling_extra_action) if castling?
    special_actions.push(passant_extra_action) if en_passant?
    special_actions.push(promotion_action) if promotion?

    special_actions
  end

  # Move this to its own module
  def promotion_action
    -> {
      populate(content.promotion_choice.new(content.color),
        movement.destination)
    }
  end

  def destination_paths
    paths + take_paths
  end

  def paths_to_positions(paths)
    paths.flatten(1)
  end

  def take_paths(path_class = Path)
    take_directions.map { |step| path_class.take_positions(origin:, board:, step:) }
  end

  def take_directions
    piece.take_directions
  end

  def paths(step_directions = self.step_directions, path_class = Path)
    step_directions.map { |step| path_class.positions(origin:, board:, step:) }
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
        attacked_positions + self.class.valid_destinations(position, board)
      end.uniq
    end
  end

  def step_directions
    piece.step_directions
  end

  def piece
    origin.piece
  end
end
