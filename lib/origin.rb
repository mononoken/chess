# frozen_string_literal: true

class Origin
  attr_reader :position, :player, :board

  def initialize(position:, player:, board:)
    @position = position
    @player = player
    @board = board
  end

  def valid?
    all_checks.all?(true)
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

  private

  def all_checks

  end

  def piece
    square.content
  end

  def square
    board.square(position)
  end
end
