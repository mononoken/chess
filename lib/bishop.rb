# frozen_string_literal: true

# Currently figuring out how a Piece object can determine valid_moves and where certain checks
# such as for squares occupied by same color pieces and such should occur.

class Bishop
  attr_reader :coordinate

  def initialize(coordinate:)
    # @position = position
    @coordinate = coordinate
    # @color = color
  end

  # Returns an array of coordinates/positions that are valid moves for the Piece
  # def valid_moves(board)
  #   movement(board.all).select do |move|
  #     valid_move?(move)
  #   end
  # end

  # Should board just be valid_coords ?
  def movement(board)
    [
      top_left_diag(coordinate, board.valid_coords),
      top_right_diag(coordinate, board.valid_coords),
      bot_left_diag(coordinate, board.valid_coords),
      bot_right_diag(coordinate, board.valid_coords)
    ].flatten(1)
  end

  private

  def top_left_diag(coord, valid_coords)
    line(coord, valid_coords, [-1, 1])
  end

  def top_right_diag(coord, valid_coords)
    line(coord, valid_coords, [1, 1])
  end

  def bot_left_diag(coord, valid_coords)
    line(coord, valid_coords, [-1, -1])
  end

  def bot_right_diag(coord, valid_coords)
    line(coord, valid_coords, [1, -1])
  end

  def line(coord, valid_coords, step)
    next_step = coord_step(coord, step)

    return [] unless valid_coord?(next_step, valid_coords)

    [next_step] + line(next_step, valid_coords, step)
  end

  def coord_step(coord, step)
    [coord, step].transpose.map(&:sum)
  end

  def valid_coord?(coord, valid_coords)
    coord.all? { |num| valid_coords.any?(num) }
  end
end
