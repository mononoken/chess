# frozen_string_literal: true

require_relative './bishop'
require_relative './king'
require_relative './knight'
require_relative './pawn'
require_relative './queen'
require_relative './rook'

# List of piece types for Chess.
module Pieces
  def self.piece_types
    [King, Queen, Bishop, Knight, Rook, Pawn]
  end
end