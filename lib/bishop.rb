# frozen_string_literal: true

# Currently figuring out how a Piece object can determine valid_moves and where certain checks
# such as for squares occupied by same color pieces and such should occur.

class Bishop
  def initialize(position:, coordinates:, color: nil)
    @position = position
    @coordinates = coordinates
    @color = color
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

  private

  # def left_diagonal_moves(board)
  #   # foo
  # end

  # def right_diagonal_moves(board)
  #   # foo
  # end
end
