# frozen_string_literal: true

require_relative './movement'

# Check for Board status in reference to the Chess game.
module CheckStatus
  def check?(piece_color)
    king = king(piece_color)
    return false if king.nil?

    all_destinations(king.opponent_color).any?(piece_position(king))
  end

  def king(color)
    all_pieces(color).find(&:checkable?)
  end

  def move_will_create_check?(origin, destination, piece_color)
    self.class.future_board(self, origin, destination).check?(piece_color)
  end

  def all_destinations(color, movement = Movement)
    all_pieces(color).map do |piece|
      movement.destinations(piece_position(piece), self)
    end.flatten(1).uniq
  end

  def all_pieces(color = nil)
    squares.filter_map(&:content).select do |content|
      content&.color == color
    end
  end
end
