# frozen_string_literal: true

# Currently figuring out how a Piece object can determine valid_moves and where certain checks
# such as for squares occupied by same color pieces and such should occur.
class Bishop
  attr_reader :coordinate, :board, :squares

  # Should coordinate be queried from board?
  def initialize(coordinate: nil, board: nil, squares: nil)
    @coordinate = coordinate
    @board = board
    @squares = squares
    # @color = color
  end

  # Dependency
  def moves
    movement - squares.obstructed_coords(paths)
  end

  def moves?
    !moves.empty?
  end

  # LIVING THE DREAM
  # Nested inside this method is a private method that
  # calls #valid_coords from Board which currently
  # does not exist.
  def movement
    paths.flatten(1)
  end

  # NO_TESTS
  # Dependency
  # Array of all possible integers in coordinates.
  def valid_coords
    squares.valid_coords
  end

  private

  # Make public and create specs?
  def paths
    [top_left_diag, top_right_diag, bot_left_diag, bot_right_diag]
  end

  def top_left_diag
    path(coordinate, [-1, 1])
  end

  def top_right_diag
    path(coordinate, [1, 1])
  end

  def bot_left_diag
    path(coordinate, [-1, -1])
  end

  def bot_right_diag
    path(coordinate, [1, -1])
  end

  def path(coord, step)
    next_coord = coord_step(coord, step)

    return [] unless valid_coord?(next_coord)

    [next_coord] + path(next_coord, step)
  end

  def coord_step(coord, step)
    [coord, step].transpose.map(&:sum)
  end

  def valid_coord?(coord)
    coord.all? { |num| valid_coords.any?(num) }
  end
end
