# frozen_string_literal: true

# Currently figuring out how a Piece object can determine valid_moves and where certain checks
# such as for squares occupied by same color pieces and such should occur.

class Bishop
  attr_reader :coordinate, :board

  def initialize(coordinate:, board:)
    @coordinate = coordinate
    @board = board
    # @color = color
  end

  def movement
    top_left_diag + top_right_diag + bot_left_diag + bot_right_diag
  end

  private

  def top_left_diag
    line(coordinate, [-1, 1])
  end

  def top_right_diag
    line(coordinate, [1, 1])
  end

  def bot_left_diag
    line(coordinate, [-1, -1])
  end

  def bot_right_diag
    line(coordinate, [1, -1])
  end

  def line(coord, step)
    next_coord = coord_step(coord, step)

    return [] unless valid_coord?(next_coord)

    [next_coord] + line(next_coord, step)
  end

  def coord_step(coord, step)
    [coord, step].transpose.map(&:sum)
  end

  def valid_coords
    board.valid_coords
  end

  def valid_coord?(coord)
    coord.all? { |num| valid_coords.any?(num) }
  end
end
