# frozen_string_literal: true

require_relative './chess_errors'

# Check if object meets the valid_origin? requirement.
module Originable
  def valid_origin?(player_color, board)
    valid_color?(player_color) && destinations?(board)
  end

  def valid_color?(player_color)
    square.content&.color == player_color
  end

  def destinations?(board)
    destinations(board).any?
  end

  def destinations(board, movement = Movement)
    movement.valid_destinations(self, board)
  end
end

require_relative './movement'

# Check if object meets the valid_destination? requirement.
module Destinationable
  def valid_destination?(origin, board, movement = Movement)
    movement.valid_destination?(self, origin, board)
  end
end

# Represent a location on a chess board that points to a Square object.
# Files are columns (vertical); ranks are rows (horizontal).
class Position
  FILE_ALGEBRAICS = %w[a b c d e f g h].freeze
  RANK_ALGEBRAICS = %w[1 2 3 4 5 6 7 8].freeze

  def self.from_a(array)
    new(file_index: array[0], rank_index: array[1])
  end

  def self.from_algebraic(algebraic_notation)
    raise InvalidNotationError if algebraic_invalid?(algebraic_notation)

    new(
      file_index: FILE_ALGEBRAICS.index(algebraic_notation[0]),
      rank_index: RANK_ALGEBRAICS.index(algebraic_notation[1])
    )
  end

  def self.algebraic_invalid?(algebraic)
    FILE_ALGEBRAICS.none?(algebraic[0]) || RANK_ALGEBRAICS.none?(algebraic[1])
  end

  include ChessErrors
  include Originable
  include Destinationable

  attr_reader :file_index, :rank_index

  def initialize(file_index:, rank_index:, square: nil)
    @file_index = file_index
    @rank_index = rank_index
    @square = square
  end

  def square(board = nil)
    return @square if board.nil?

    board.square(self)
  end

  def algebraic
    "#{file_algebraic}#{rank_algebraic}".to_sym
  end

  def to_a
    [file_index, rank_index]
  end

  def piece_color?(color)
    square.piece_color?(color)
  end

  def ==(other)
    other.file_index == file_index && other.rank_index == rank_index
  end

  def step(step)
    self.class.new(file_index: file_index + step[0], rank_index: rank_index + step[1])
  end

  def file_algebraic
    FILE_ALGEBRAICS[file_index]
  end

  def rank_algebraic
    RANK_ALGEBRAICS[rank_index]
  end
end

require_relative './null_object'

# NullObject for Position
class NullPosition < NullObject; end
