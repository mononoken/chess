# frozen_string_literal: true

require_relative "./colorable_string"
require_relative "./chess_errors"
require_relative "./nil_object"
require_relative "./pieces/piece"

# NilObject for Position
class NilPosition < NilObject
  def piece
    NilPiece.new
  end
end

# Check if object meets the valid_origin? requirement.
module Originable
  def valid_origin?(player_color, board)
    valid_color?(player_color) && destinations?(board)
  end

  private

  def valid_color?(player_color)
    piece.color == player_color
  end

  def destinations?(board)
    destinations(board).any?
  end

  # def destinations(board, movement_class = Movement)
  #   movement_class.valid_destinations(self, board)
  # end

  def destinations(board, movement_class = Movement)
    movement_class.valid_destinations(self, board)
  end
end

require_relative "./movement"

# Check if object meets the valid_destination? requirement.
module Destinationable
  def valid_destination?(origin, board, movement_class = Movement)
    movement_class.valid_destination?(self, origin, board)
  end

  # FIX_ME: Currently, pieces are able to jump outside of border to the other side of board.
  def valid_destinations(board, movement_class = Movement)
    movement_class.valid_destinations(self, board)
  end

  def paths_positions(board, movement_class = Movement)
    movement_class.paths_positions(self, board)
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
class Position
  using ColorableString

  include ChessErrors
  include Algebraic
  include Originable
  include Destinationable

  attr_reader :file_index, :rank_index, :square_color
  attr_accessor :piece

  # Files are columns (vertical); ranks are rows (horizontal).
  def initialize(file_index:, rank_index:, square_color: nil, piece: NilPiece.new)
    @file_index = file_index
    @rank_index = rank_index
    @square_color = square_color
    @piece = piece
  end

  def nil_piece?
    piece.is_a?(NilPiece)
  end

  def fill(piece)
    self.piece = piece
  end

  def empty?
    piece.instance_of?(NilPiece)
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

  # def step(step)
  #   self.class.new(file_index: file_index + step[0], rank_index: rank_index + step[1])
  # end

  def step(step, board)
    position = self.class.new(file_index: file_index + step[0], rank_index: rank_index + step[1])
    board.position(position.algebraic)
    # board.positions.find { |board_position| board_position == position }
    board.positions.position_position(position)
  end

  def to_s
    " #{piece.to_s.chomp("\e[0m")} ".bg_color(square_color)
  end
end
