# frozen_string_literal: true

# Represent a location on a chess board.
# Files are columns (vertical); ranks are rows (horizontal).
class Position
  FILE_ALGEBRAICS = %w[a b c d e f g h].freeze
  RANK_ALGEBRAICS = %w[1 2 3 4 5 6 7 8].freeze

  class InvalidNotationError < StandardError
    def message
      'Invalid notation selected.'
    end
  end

  def self.from_a(array)
    new(file_index: array[0], rank_index: array[1])
  end

  def self.from_algebraic(algebraic_notation)
    new(
      file_index: FILE_ALGEBRAICS.index(algebraic_notation[0]),
      rank_index: RANK_ALGEBRAICS.index(algebraic_notation[1])
    )
  end

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
    Position.new(file_index: file_index + step[0], rank_index: rank_index + step[1])
  end

  private

  def file_algebraic
    FILE_ALGEBRAICS[file_index]
  end

  def rank_algebraic
    RANK_ALGEBRAICS[rank_index]
  end
end
