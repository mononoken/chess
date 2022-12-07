# frozen_string_literal: true

class Origin
  attr_reader :position, :player, :board

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
    [on_board?, piece?, player_owns?, piece_can_move?]
  end

  def piece_can_move?
    piece.moves?
  end

  def player_owns?
    piece&.color == player.color
  end

  def piece?
    !square.empty?
  end

  def on_board?
    board.position_exists?(position)
  end

  def piece
    square.content
  end

  def square
    board.square(position)
  end
end
