# frozen_string_literal: true

require_relative "./chess_errors"
require_relative "./check_status"
require_relative "./positions"
require_relative "./en_passant"

# Processes Movement objects to manipulate Positions.
class Board
  include ChessErrors
  include CheckStatus
  include EnPassant::PassantRecorder

  attr_reader :positions

  def initialize(positions: Positions.new, piece_types: nil)
    @positions = positions
    init_piece_types(piece_types)
  end

  def position(algebraic)
    positions.position(algebraic)
  end

  def move(movement)
    raise EmptyOriginError if movement.origin.nil_piece?

    reset_passantables(positions.map(&:piece))

    content = movement.origin.empty

    record_passantable(content)
    record_first_move(content)

    populate(content, movement.destination)
  end

  def record_first_move(piece)
    piece.take_first_move unless piece.first_move_taken?
  end

  def populate(piece, position)
    position.fill(piece)
  end

  def occupied_positions(color = nil)
    positions.occupied_positions(color)
  end

  def to_s
    "   a  b  c  d  e  f  g  h\n" \
    "#{rank_to_s_with_label(ranks[7])}\n" \
    "#{rank_to_s_with_label(ranks[6])}\n" \
    "#{rank_to_s_with_label(ranks[5])}\n" \
    "#{rank_to_s_with_label(ranks[4])}\n" \
    "#{rank_to_s_with_label(ranks[3])}\n" \
    "#{rank_to_s_with_label(ranks[2])}\n" \
    "#{rank_to_s_with_label(ranks[1])}\n" \
    "#{rank_to_s_with_label(ranks[0])}\n" \
    "   a  b  c  d  e  f  g  h"
  end

  private

  def rank_to_s_with_label(rank)
    "#{rank_label(rank)} #{rank_to_s(rank)} #{rank_label(rank)}"
  end

  def rank_to_s(rank)
    rank.reduce(+"") do |rank_s, position|
      rank_s << position.to_s
    end
  end

  def rank_label(rank_array)
    rank_array.first.rank_algebraic
  end

  def ranks
    positions.ranks
  end

  def files
    positions.files
  end

  def file(index)
    files[index]
  end

  def rank(index)
    ranks[index]
  end

  # Places piece types at start positions if piece_types is given.
  def init_piece_types(piece_types)
    piece_types&.each { |piece_type| init_start_positions(piece_type) }
  end

  def init_start_positions(piece_type)
    piece_type.start_positions.each do |start_position|
      populate(piece_type.new(start_position.color), position(start_position.algebraic))
    end
  end
end
