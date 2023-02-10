# frozen_string_literal: true

require_relative './bishop'
require_relative './king'
require_relative './knight'
require_relative './pawn'
require_relative './queen'
require_relative './rook'

# List of piece types for Chess.
module Pieces
  PIECE_CLASSES = [King, Queen, Bishop, Knight, Rook, Pawn].freeze

  def self.piece_types
    PIECE_CLASSES
  end

  def self.pawn_promotion_option?(choice)
    pawn_promotion_options.any?(choice)
  end

  def self.pawn_promotion_options
    [Queen, Knight, Bishop, Rook].map(&:algebraic)
  end

  def self.piece_class(algebraic)
    PIECE_CLASSES.find { |piece_class| piece_class.algebraic == algebraic }
  end
end
