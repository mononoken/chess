# frozen_string_literal: true

require_relative './square'
require_relative './check_status'
require_relative './positions'

# Stores and manipulates Squares in a 2-D array, organized into 'files'.
class Board
  class EmptyOriginError < StandardError
    def message
      'Move sent to an empty origin.'
    end
  end

  # Instantiate a notional board that makes the given move.
  def self.future_board(board, origin, destination)
    future_board = new(files: Marshal.load(Marshal.dump(board.files)))
    future_board.move(origin, destination)
    future_board
  end

  include CheckStatus

  attr_reader :files, :positions

  def initialize(files: empty_files, positions: PositionsFactory.build(files), piece_types: nil)
    @files = files
    @positions = positions
    init_piece_types(piece_types)
  end

  def positions_algebraic
    positions.algebraic
  end

  def move(origin, destination)
    raise EmptyOriginError if square(origin).empty?

    content = square(origin).empty

    square(destination).fill(content)
  end

  def populate(piece, position)
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
    "#{ranks.reverse.map do |rank|
      "#{rank_label(rank)} #{rank_to_s(rank)}\n"
    end.join}   a  b  c  d  e  f  g  h"
  end

  private

  def rank_to_s(rank)
    rank.reduce(+'') do |rank_s, square|
      rank_s << square.to_s
    end
  end

  def rank_label(rank)
    position(rank[0]).rank_algebraic
  end

  def ranks
    (0..7).to_a.map { |index| rank(index) }
  end

  def rank(index)
    files.map { |file| file[index] }
  end

  def position(square)
    positions.find { |position| position.square == square }
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
