# frozen_string_literal: true

require_relative './position'

require 'forwardable'

# Manage an array of position objects.
class Positions
  extend Forwardable
  def_delegators :@positions, :any?, :filter, :find, :map, :reject
  include Enumerable

  attr_reader :positions

  def initialize(positions)
    @positions = positions
  end

  def algebraic
    map(&:algebraic)
  end

  def piece_position(piece)
    find { |position| position.square.content == piece }
  end

  def occupied_positions(color = nil)
    if color.nil?
      reject { |position| position.square.empty? }
    else
      filter { |position| position.piece_color?(color) }
    end
  end
end

# Create instances of Positions.
module PositionsFactory
  def self.build(files, positions_class = Positions)
    positions_class.new(positions_array(files))
  end

  # Create positions array from 2D array from Chess board files.
  def self.positions_array(files)
    files.each_with_object([]).with_index do |(file, positions), file_index|
      file.each_with_index do |square, rank_index|
        positions << new_position(file_index:, rank_index:, square:)
      end
    end
  end

  def self.new_position(file_index:, rank_index:, square:, position_class: Position)
    position_class.new(file_index:, rank_index:, square:)
  end
end
