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

  # def valid_move?(move, board)
  #   is_free?(move, board) || is_capture?(move, board)
  # end

  # def movement(board)
  #   [left_diagonal_moves, right_diagonal_moves].flatten(1)
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
    step = [-1, 1]
    next_step = coord_step(coord, step)

    return [] unless valid_coord?(next_step, valid_coords)

    [next_step] + top_left_diag(next_step, valid_coords)
  end

  def top_right_diag(coord, valid_coords)
    step = [1, 1]
    next_step = coord_step(coord, step)

    return [] unless valid_coord?(next_step, valid_coords)

    [next_step] + top_right_diag(next_step, valid_coords)
  end

  def bot_left_diag(coord, valid_coords)
    step = [-1, -1]
    next_step = coord_step(coord, step)

    return [] unless valid_coord?(next_step, valid_coords)

    [next_step] + bot_left_diag(next_step, valid_coords)
  end

  def bot_right_diag(coord, valid_coords)
    step = [1, -1]
    next_step = coord_step(coord, step)

    return [] unless valid_coord?(next_step, valid_coords)

    [next_step] + bot_right_diag(next_step, valid_coords)
  end

  def coord_step(coord, step)
    [coord, step].transpose.map(&:sum)
  end

  def valid_coord?(coord, valid_coords)
    coord.all? { |num| valid_coords.any?(num) }
  end
end
