# frozen_string_literal: true

class Destination
  def valid?
    checks.all?(true)
  end

  private

  def checks
  end
end

class Destination_old
  attr_reader :position, :board

  def initialize(position:, player:, board:)
    @position = position
    @player = player
    @board = board
  end

  def valid?
    checks.all?(true)
  end

  private

  def checks
    [on_board?, piece_can_move?]
  end

  def piece_can_move?
    piece.moves?
  end

  def on_board?
    board.position_exists?(position)
  end

  def piece
    # NOT THE SAME
  end

  def square
    board.square(position)
  end
end
