# frozen_string_literal: true

# Check position is a valid destination for an origin.
class Destination
  attr_reader :position, :origin

  def initialize(position:, origin:)
    @position = position
    @origin = origin
  end

  def valid?
    on_board? && position_is_reachable?
  end

  def position_is_reachable?
    piece.valid_move?(position)
  end

  def on_board?
    board.position_exists?(position)
  end

  private

  def piece
    origin.piece
  end

  def board
    origin.board
  end
end
