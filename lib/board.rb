# frozen_string_literal: true

require_relative './square'
require_relative './check_status'

# Stores and manipulates Squares in a 2-D array, organized into 'files'.
class Board
  class EmptyOriginError < StandardError
    def message
      'Move sent to an empty origin.'
    end
  end

  # Instantiate a notional board that makes the given move.
  def self.future_board(board, origin, destination)
    future_board = new(files: Marshal.load(Marshal.dump(board.files)))
    future_board.move(origin, destination)
    future_board
  end

  include CheckStatus

  attr_reader :files

  def initialize(files: empty_files, piece_types: nil)
    @files = files
    init_piece_types(piece_types)
  end

  def move(origin, destination)
    raise EmptyOriginError if square(file: origin[0], rank: origin[1]).empty?

    content = square(file: origin[0], rank: origin[1]).empty

    square(file: destination[0], rank: destination[1]).fill(content)
  end

  def populate(piece, position)
    square(file: position[0], rank: position[1]).fill(piece)
  end

  def piece_position(piece)
    position(squares.find { |square| square.content == piece })
  end

  def piece(position)
    square(file: position[0], rank: position[1]).content
  end

  def positions(files = self.files)
    squares.map { |square| position(square) }
  end

  def occupied_positions(color = nil)
    occupied_squares(color).map { |square| position(square) }
  end

  def squares
    files.flatten
  end

  def to_s
    <<~HEREDOC
      +----+----+----+----+----+----+----+----+
      #{ranks.reverse.map { |rank| "#{rank_to_s(rank)}\n+----+----+----+----+----+----+----+----+\n" }.join.strip}
    HEREDOC
  end

  private

  def occupied_squares(color)
    if color.nil?
      squares.reject(&:empty?)
    else
      squares.select { |square| square.piece_color?(color) }
    end
  end

  def rank_to_s(rank)
    rank.reduce(+'|') do |rank_s, square|
      rank_s << " #{square}  |"
    end
  end

  def ranks
    ranks_boundaries.to_a.map { |index| rank(index) }
  end

  def rank(index)
    files.map { |file| file[index] }
  end

  def ranks_boundaries
    (0..files.reduce(files[0].count) { |count, rank| [count, rank.count].min } - 1)
  end

  def position(square)
    files.map.with_index do |file, file_index|
      file.map.with_index do |board_square, rank_index|
        [file_index, rank_index] if board_square == square
      end
    end.flatten.compact
  end

  def square(file: nil, rank: nil)
    files[file][rank]
  end

  # Places piece types at start positions if piece_types is given.
  def init_piece_types(piece_types)
    piece_types&.each { |piece_type| init_start_positions(piece_type) }
  end

  def init_start_positions(piece_type)
    piece_type.start_positions.each do |start_position|
      populate(piece_type.new(start_position.color), start_position.position)
    end
  end

  def empty_files
    Array.new(8) { Array.new(8) { Square.new } }
  end
end
