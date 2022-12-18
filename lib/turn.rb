# frozen_string_literal: true

class Turn
  def self.run(board, player)
    new(board, player).run
  end

  attr_reader :board, :player

  def initialize(board, player)
    @board = board
    @player = player
  end

  def run
    # Pending behavior requests from Turn.
  end
end
