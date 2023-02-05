# frozen_string_literal: true

require_relative './position'

require 'forwardable'

# Manage an array of positions given squares from a Board's files.
class Positions
  extend Forwardable
  def_delegators :@positions, :any?, :find
  include Enumerable

  attr_reader :files, :positions

  def initialize(files)
    @files = files
    @positions ||= init_positions(files)
  end

  private

  def init_positions(files)
    files.each_with_object([]).with_index do |(file, positions), file_index|
      file.each_with_index do |square, rank_index|
        positions << new_position(file_index:, rank_index:, square:)
      end
    end
  end

  def new_position(file_index:, rank_index:, square:, position_class: Position)
    position_class.new(file_index:, rank_index:, square:)
  end
end
