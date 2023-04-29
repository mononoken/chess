# frozen_string_literal: true

require_relative './position'
require_relative './pieces/piece'

require 'forwardable'

# Manage an array of position objects.
class Positions
  FILE_INDECES = (0..7).to_a.freeze
  RANK_INDECES = (0..7).to_a.freeze

  extend Forwardable
  def_delegators :@positions, :any?, :filter, :filter_map, :find, :map, :reject
  include Enumerable

  attr_reader :positions

  def initialize(positions = default_chess_positions)
    @positions = positions
  end

  def position(algebraic)
    find { |position| position.algebraic == algebraic } || NilPosition.new
  end

  # Return position that has indeces matching the delta from step on position.
  def relative_position(position, step)
    return NilPosition.new if position.is_a?(NilPosition)

    file_index = position.file_index + step[0]
    rank_index = position.rank_index + step[1]

    positions.find do |a_position|
      a_position.file_index == file_index &&
        a_position.rank_index == rank_index
    end || NilPosition.new
  end

  # DELETE_ME if unused
  def position_position(position)
    find { |a_position| a_position == position } || NilPosition.new
  end

  def algebraics
    map(&:algebraic)
  end

  def piece_position(piece)
    find { |position| position.piece == piece } || NilPosition.new
  end

  def occupied_positions(color = nil)
    if color.nil?
      reject(&:empty?)
    else
      filter { |position| position.piece_color?(color) }
    end
  end

  def files
    positions.group_by(&:file_index)
  end

  def ranks
    positions.group_by(&:rank_index)
  end

  def default_chess_positions
    color_cycle = %i[
      dark light dark light dark light dark light
      light dark light dark light dark light dark
    ].cycle

    FILE_INDECES.product(RANK_INDECES).map do |file_index, rank_index|
      Position.new(file_index:, rank_index:, piece: NilPiece.new,
                   square_color: color_cycle.next)
    end
  end
end
