# frozen_string_literal: true

require_relative './chess_errors'
require_relative './nil_object'

# NilObject for Position
class NilPosition < NilObject; end

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

# Allows a position with file and rank indeces to convert to algebraic notation.
module Algebraic
  FILE_ALGEBRAICS = %w[a b c d e f g h].freeze
  RANK_ALGEBRAICS = %w[1 2 3 4 5 6 7 8].freeze

  def algebraic
    "#{file_algebraic}#{rank_algebraic}".to_sym
  end

  def file_algebraic
    FILE_ALGEBRAICS[file_index]
  end

  def rank_algebraic
    RANK_ALGEBRAICS[rank_index]
  end
end

# Tracks the piece at a specified file index and rank index pair.
class NewPosition
  # Used in Board
  def self.from_a(array)
    new(file_index: array[0], rank_index: array[1])
  end

  include ChessErrors
  include Algebraic
  include Originable
  include Destinationable

  attr_reader :file_index, :rank_index
  attr_accessor :piece

  # Files are columns (vertical); ranks are rows (horizontal).
  def initialize(file_index:, rank_index:, piece: nil)
    @file_index = file_index
    @rank_index = rank_index
    @piece = piece
  end

  def fill(piece)
    self.piece = piece
  end

  def empty
    previous_piece = piece
    self.piece = NilPiece.new
    previous_piece
  end

  def piece_color?(color)
    piece.color == color
  end

  def ==(other)
    other.file_index == file_index && other.rank_index == rank_index
  end

  def step(step)
    self.class.new(file_index: file_index + step[0], rank_index: rank_index + step[1])
  end
end

class Position
  # Used in Board
  def self.from_a(array)
    new(file_index: array[0], rank_index: array[1])
  end

  include ChessErrors
  include Algebraic
  include Originable
  include Destinationable

  attr_reader :file_index, :rank_index

  def initialize(file_index:, rank_index:, square: nil, piece: nil)
    @file_index = file_index
    @rank_index = rank_index
    @square = square
    @piece = piece
  end

  def square(board = nil)
    return @square if board.nil?

    board.square(self)
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
end
