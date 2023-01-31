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

  # def self.letter_skins(color)
  #   {
  #     pawn: 'P',
  #     rook: 'R',
  #     knight: 'N',
  #     bishop: 'B',
  #     queen: 'Q',
  #     king: 'K'
  #   }
  # end

  def self.piece_letter_visuals(color)
    if color == :white
      {
        Pawn: 'P'.white,
        Rook: 'R'.white,
        Knight: 'N'.white,
        Bishop: 'B'.white,
        Queen: 'Q'.white,
        King: 'K'.white
      }
    else
      {
        Pawn: 'P',
        Rook: 'R',
        Knight: 'N',
        Bishop: 'B',
        Queen: 'Q',
        King: 'K'
      }
    end
  end
end
