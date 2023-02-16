# frozen_string_literal: true

require_relative './path'

require 'pry-byebug'

module Castling
  WHITE_CASTLING_ALGEBRAICS = %i[c1 g1].freeze
  WHITE_KING_ORIGIN_ALGEBRAIC = :e1
  BLACK_CASTLING_ALGEBRAICS = %i[c8 g8].freeze
  BLACK_KING_ORIGIN_ALGEBRAIC = :e8

  CASTLING_ROOK_ORIGINS = {
    c1: :a1,
    g1: :h1,
    c8: :a8,
    g8: :h8
  }.freeze
  CASTLING_KING_DESTINATIONS = {
    c1: :c1,
    g1: :g1,
    c8: :c8,
    g8: :g8
  }.freeze
  CASTLING_ROOK_DESTINATIONS = {
    c1: :d1,
    g1: :f1,
    c8: :d8,
    g8: :f8
  }.freeze
  CASTLING_BETWEEN_POSITIONS = {
    c1: %i[b1 c1 d1],
    g1: %i[f1 g1],
    c8: %i[b8 c8 d8],
    g8: %i[f8 g8]
  }.freeze

  def valid_castling_positions(piece, board)
    castling_positions(piece, board).filter { |position| valid_castling_position?(position, piece, board) }
  end

  def castling_positions(piece, board)
    castling_algebraics(piece).map do |algebraic|
      board.positions.position(algebraic)
    end.filter { |position| position.class != NullPosition }
  end

  def castling_algebraics(piece)
    case piece.color
    when :white
      WHITE_CASTLING_ALGEBRAICS
    when :black
      BLACK_CASTLING_ALGEBRAICS
    end
  end

  def valid_castling_position?(position, piece, board)
    castling_criteria(position, piece, board).all?
  end

  def castling_criteria(position, piece, board)
    [
      castling_pieces_unmoved?(position.algebraic, piece, board),
      no_pieces_between?(position.algebraic, board)
    ]
  end

  # first_move_taken? rename to inverse and shorten name?
  def castling_pieces_unmoved?(castling_algebraic, piece, board)
    !castling_king_origin(piece, board)&.square&.content&.first_move_taken? && !board.positions.position(CASTLING_ROOK_ORIGINS[castling_algebraic])&.square&.content&.first_move_taken?
  end

  def castling_king_origin(piece, board)
    case piece.color
    when :white
      board.positions.position(WHITE_KING_ORIGIN_ALGEBRAIC)
    when :black
      board.position.position(BLACK_KING_ORIGIN_ALGEBRAIC)
    end
  end

  def no_pieces_between?(castling_algebraic, board)
    CASTLING_BETWEEN_POSITIONS[castling_algebraic].map do |algebraic|
      board.positions.position(algebraic)
    end.all? { |position| position.square.empty? }
  end

  # def king_in_check?
  # end

  # def king_will_be_in_check?
  # end
end

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

  include Castling

  attr_reader :origin, :board

  def initialize(origin, board)
    @origin = origin
    @board = board
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

  def paths(directions = step_directions, path = Path)
    directions.map { |step| path.positions(origin:, board:, step:) }
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
    @piece ||= board.piece(origin)
  end
end
