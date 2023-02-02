# frozen_string_literal: true

require_relative './position'

# Manage an array of positions.
class Positions
  attr_reader :files, :all

  def initialize(files)
    @files = files
    @all ||= init_positions(files)
  end

  def init_positions(files)
    files.each_with_object([]).with_index do |(file, all_positions), file_index|
      file.each_with_index do |square, rank_index|
        all_positions << Position.new(file_index:, rank_index:, square:)
      end
    end
  end

  def from_square(square)
    all.find { |position| position.square == square }
  end

  def fetch(file_index:, rank_index:)
    all.any? { |position| position.file_index == file_index && position.rank_index == rank_index }
  end

  def fetch_from_a(array)
    all.any? { |position| position.to_a == array }
  end
end
