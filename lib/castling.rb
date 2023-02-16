# frozen_string_literal: true

# Think this may actually become a subclass of Movement.
module Castling
  WHITE_CASTLING_ALGEBRAICS = %i[c1 g1].freeze
  WHITE_KING_ORIGIN_ALGEBRAIC = :e1
  BLACK_CASTLING_ALGEBRAICS = %i[c8 g8].freeze
  BLACK_KING_ORIGIN_ALGEBRAIC = :e8

  CASTLING_ROOK_ORIGINS = {
    c1: :a1,
    g1: :h1,
    c8: :a8,
    g8: :h8
  }.freeze
  CASTLING_KING_DESTINATIONS = {
    c1: :c1,
    g1: :g1,
    c8: :c8,
    g8: :g8
  }.freeze
  CASTLING_ROOK_DESTINATIONS = {
    c1: :d1,
    g1: :f1,
    c8: :d8,
    g8: :f8
  }.freeze
  CASTLING_BETWEEN_POSITIONS = {
    c1: %i[b1 c1 d1],
    g1: %i[f1 g1],
    c8: %i[b8 c8 d8],
    g8: %i[f8 g8]
  }.freeze

  # def castling?(piece, board, destination)
  #   valid_castling_positions(piece, board).any?(destination)
  # end

  def valid_castling_positions(piece, board)
    castling_positions(piece, board).filter { |position| valid_castling_position?(position, piece, board) }
  end

  def castling_positions(piece, board)
    castling_algebraics(piece).map do |algebraic|
      board.positions.position(algebraic)
    end.filter { |position| position.class != NullPosition }
  end

  def castling_algebraics(piece)
    case piece.color
    when :white
      WHITE_CASTLING_ALGEBRAICS
    when :black
      BLACK_CASTLING_ALGEBRAICS
    end
  end

  def valid_castling_position?(position, piece, board)
    castling_criteria(position, piece, board).all?
  end

  def castling_criteria(position, piece, board)
    [
      castling_pieces_unmoved?(position.algebraic, piece, board),
      no_pieces_between?(position.algebraic, board)
    ]
  end

  # first_move_taken? rename to inverse and shorten name?
  def castling_pieces_unmoved?(castling_algebraic, piece, board)
    !castling_king_origin(piece, board)&.square&.content&.first_move_taken? && !board.positions.position(CASTLING_ROOK_ORIGINS[castling_algebraic])&.square&.content&.first_move_taken?
  end

  def castling_king_origin(piece, board)
    case piece.color
    when :white
      board.positions.position(WHITE_KING_ORIGIN_ALGEBRAIC)
    when :black
      board.position.position(BLACK_KING_ORIGIN_ALGEBRAIC)
    end
  end

  def no_pieces_between?(castling_algebraic, board)
    CASTLING_BETWEEN_POSITIONS[castling_algebraic].map do |algebraic|
      board.positions.position(algebraic)
    end.all? { |position| position.square.empty? }
  end

  # def king_in_check?
  # end

  # def king_will_be_in_check?
  # end
end
