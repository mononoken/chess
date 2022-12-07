# frozen_string_literal: true

class Origin
  attr_reader :position, :board

  def initialize(position:, board:)
    @position = position
    @board = board
  end

  def valid?
    all_checks.all?(true)
  end

  def piece?
    !square.empty?
  end

  def on_board?
    board.position_exists?(position)
  end

  def square
    board.square(position)
  end

  private

  def all_checks

  end
end
