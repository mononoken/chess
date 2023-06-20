# frozen_string_literal: true

require_relative "./bishop"
require_relative "./king"
require_relative "./knight"
require_relative "./pawn"
require_relative "./queen"
require_relative "./rook"

# List of piece types for Chess.
module Pieces
  PIECE_CLASSES = [King, Queen, Bishop, Knight, Rook, Pawn].freeze

  def self.piece_types
    PIECE_CLASSES
  end
end
