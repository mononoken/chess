# frozen_string_literal: true

require_relative './square'

class Board
  class EmptyOriginError < StandardError
    def message
      'Move sent to an empty origin.'
    end
  end

  attr_reader :squares, :coordinator

  def initialize(squares = default_squares, coordinator = Coordinator.new(self))
    @squares = squares
    @coordinator = coordinator
  end

  def move(origin, destination)
    raise EmptyOriginError if square(origin).empty?

    content = square(origin).empty

    square(destination).fill(content)
  end

  def populate(piece, position)
    square(position).fill(piece)
  end

  def piece(position)
    square(position).content
  end

  def boundaries
    {
      files: files_boundaries,
      ranks: ranks_boundaries
    }
  end

  def occupied_positions(color)
    occupied_squares(color).map { |square| coordinator.position(square) }
  end

  private

  def default_squares
    Array.new(8) { Array.new(8) { Square.new } }
  end

  def occupied_squares(color)
    squares.flatten.select { |square| square.piece_color?(color) }
  end

  # def positions
  #   squares.map.with_index do |file, file_index|
  #     file.map.with_index { |_, rank_index| [file_index, rank_index] }
  #   end.flatten(1)
  # end

  def files_boundaries
    (0..squares.count - 1)
  end

  def ranks_boundaries
    (0..squares.reduce(squares[0].count) { |count, rank| [count, rank.count].min } - 1)
  end

  def square(position)
    squares[position[0]][position[1]]
  end
end

class Coordinator
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def position(square)
    squares.map.with_index do |file, file_index|
      file.map.with_index do |board_square, rank_index|
        [file_index, rank_index] if board_square == square
      end
    end.flatten.compact
  end

  private

  def squares
    board.squares
  end
end
