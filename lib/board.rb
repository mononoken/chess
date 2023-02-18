# frozen_string_literal: true

require_relative './chess_errors'
require_relative './square'
require_relative './check_status'
require_relative './positions'

# Stores and manipulates Squares in a 2-D array, organized into 'files'.
class Board
  # Instantiate a notional board that makes the given move.
  def self.future_board(board, origin, destination)
    future_board = new(files: Marshal.load(Marshal.dump(board.files)))
    future_board.hypothetical_move(origin, destination)
    future_board
  end

  include ChessErrors
  include CheckStatus

  attr_reader :files, :positions

  def initialize(files: empty_files, positions: PositionsFactory.build(files), piece_types: nil)
    @files = files
    @positions = positions
    init_piece_types(piece_types)
  end

  def position(algebraic)
    positions.position(algebraic)
  end

  def positions_algebraics
    positions.algebraics
  end

  def process_movement(movement)
    if movement.promotion?
      # populate(movement.promotion_choice, movement.destination)
      populate(content.promotion_choice.new(content.color), movement.destination)
    # elsif movement&.castling?
      # castling_move(movement)
    else
      move(movement)
    end
  end

  def move(movement)
    raise EmptyOriginError if square(movement.origin).empty?

    content = square(movement.origin).empty

    record_move(content)

    populate(content, movement.destination)
  end

  def record_move(piece)
    piece.take_first_move unless piece.first_move_taken?
  end

  # move without promotion to avoid promotion prompt for future_boards.
  def hypothetical_move(origin, destination)
    content = square(origin).empty

    populate(content, destination)
  end

  def populate(piece, position)
    square(position).fill(piece)
  end

  # IMPLEMENT? FIX_ME
  def populate_algebraic(piece, algebraic_position)
    square(position).fill(piece)
  end

  def piece_position(piece)
    positions.piece_position(piece)
  end

  def occupied_positions(color = nil)
    positions.occupied_positions(color)
  end

  def piece(position)
    # Alternative?: position.square.content
    square(position).content
  end

  def square(position)
    files[position.file_index][position.rank_index]
  end

  def squares
    files.flatten
  end

  def to_s
    rank_color_cycles = [%i[light dark].cycle, %i[dark light].cycle].cycle

    "   a  b  c  d  e  f  g  h\n#{ranks.reverse.map do |rank|
      "#{rank_label(rank)} #{rank_to_s(rank, rank_color_cycles.next)} #{rank_label(rank)}\n"
    end.join}   a  b  c  d  e  f  g  h"
  end

  private

  def rank_to_s(rank, square_color_cycle = %i[dark light].cycle)
    rank.reduce(+'') do |rank_s, square|
      rank_s << square.to_s(square_color_cycle&.next)
    end
  end

  def rank_label(rank_array)
    positions.find_square(rank_array.first).rank_algebraic
  end

  def ranks
    (0..7).to_a.map { |index| rank(index) }
  end

  def rank(index)
    files.map { |file| file[index] }
  end

  # Places piece types at start positions if piece_types is given.
  def init_piece_types(piece_types)
    piece_types&.each { |piece_type| init_start_positions(piece_type) }
  end

  def init_start_positions(piece_type)
    piece_type.start_positions.each do |start_position|
      populate(piece_type.new(start_position.color), Position.from_a(start_position.position))
    end
  end

  def empty_files
    Array.new(8) { Array.new(8) { Square.new } }
  end
end
