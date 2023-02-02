# frozen_string_literal: true

# Represent a location on a chess board.
# Files are columns; ranks are rows.
class Position
  def self.from_a(array)
    new(file_index: array[0], rank_index: array[1])
  end

  FILE_LABELS = %w[a b c d e f g h].freeze
  RANK_LABELS = %w[1 2 3 4 5 6 7 8].freeze

  attr_reader :file_index, :rank_index, :square

  def initialize(file_index:, rank_index:, square: nil)
    @file_index = file_index
    @rank_index = rank_index
    @square = square
  end

  def to_sym
    "#{file_label}#{rank_label}".to_sym
  end

  def to_a
    [file_index, rank_index]
  end

  def ==(other)
    other.file_index == file_index && other.rank_index == rank_index
  end

  def step(step)
    Position.new(file_index: file_index + step[0], rank_index: rank_index + step[1])
  end

  private

  def file_label
    FILE_LABEL[file_index]
  end

  def rank_label
    RANK_LABELS[rank_index]
  end
end
