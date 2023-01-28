# frozen_string_literal: true

require_relative './movement'

# Check for Board status in reference to the Chess game.
module CheckStatus
  def move_will_create_check?(origin, destination, piece_color)
    self.class.future_board(self, origin, destination).check?(piece_color)
  end

  def checkmate?(piece_color)
    check?(piece_color) && all_valid_destinations(piece_color).empty?
  end

  # Investigate!
  def check?(piece_color)
    king = king(piece_color)
    return false if king.nil?

    all_attacks(king.opponent_color).any?(piece_position(king))
  end

  # It should not have to find the piece objects every time. Resource intense.
  def king(color)
    all_pieces(color).find(&:checkable?)
  end

  # Too heavy with full board and enemy pieces exist.
  def all_valid_destinations(color, movement = Movement)
    all_pieces(color).map do |piece|
      movement.valid_destinations(piece_position(piece), self)
    end.flatten(1).uniq
  end

  # Too heavy with full board and enemy pieces exist.
  def all_attacks(color, movement = Movement)
    all_pieces(color).map do |piece|
      movement.paths_positions(piece_position(piece), self)
    end.flatten(1).uniq
  end

  def all_pieces(color = nil)
    squares.filter_map(&:content).select do |content|
      content&.color == color
    end
  end
end
