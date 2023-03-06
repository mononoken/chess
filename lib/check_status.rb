# frozen_string_literal: true

# Check for Board status in reference to the Chess game.
module CheckStatus
  def move_will_create_check?(origin, destination, piece_color)
    future_board(origin, destination).check?(piece_color)
  end

  # Instantiate a notional board that makes the given move.
  def future_board(origin, destination)
    future_board = self.class.new(positions: Marshal.load(Marshal.dump(positions)))
    future_board.hypothetical_move(origin, destination)
    future_board
  end

  # move without promotion to avoid promotion prompt for future_boards.
  def hypothetical_move(origin, destination)
    populate(origin.empty, destination)
  end

  def checkmate?(piece_color)
    check?(piece_color) && all_valid_destinations(piece_color).empty?
  end

  # def check?(piece_color)
  #   king = king(piece_color)
  #   # return false if king.nil? Remove because of NilPiece

  #   all_attacks(king.opponent_color).any?(piece_position(king))
  # end

  def check?(piece_color)
    king = king(piece_color)
    return false if king.nil?

    all_attacks(king.opponent_color).any?(piece_position(king))
  end

  def piece_position(piece)
    positions.find { |position| position.piece == piece }
  end

  def king(color)
    all_pieces(color).find(&:checkable?)
  end

  def all_valid_destinations(color)
    positions.filter_map do |position|
      position.valid_destinations(self) if position.piece.color == color
    end.flatten(1).uniq
  end

  def all_attacks(color)
    positions.filter_map do |position|
      position.paths_positions(self) if position.piece.color == color
    end.flatten(1).uniq
  end

  def all_pieces(color)
    positions.map(&:piece).select do |piece|
      piece.color == color
    end
  end
end
