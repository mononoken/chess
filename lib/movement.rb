# frozen_string_literal: true

require_relative './path'

class Movement
  def self.valid_destination?(destination, origin, board)
    new(origin, board).valid_destination?(destination)
  end

  def self.destinations(origin, board)
    new(origin, board).destinations
  end

  attr_reader :origin, :board

  def initialize(origin, board)
    @origin = origin
    @board = board
  end

  def valid_destination?(destination)
    destinations.any?(destination)
  end

  def destinations
    if piece.checkable?
      paths.flatten(1) - positions_under_attack(opponent_color(piece.color))
    else
      paths.flatten(1)
    end
  end

  private

  def paths(path = Path)
    step_directions.map { |step| path.positions(origin:, board:, step:) }
  end

  def positions_under_attack(color)
    if color.nil?
      []
      # This is a bandaid. nil should actually give all attacks.
    else
      board.occupied_positions(color).reduce([]) do |attacked_positions, position|
        attacked_positions + Movement.destinations(position, board)
      end.uniq
    end
  end

  def step_directions
    piece.step_directions
  end

  # This feels like it does not belong in this class.
  def opponent_color(color)
    case color
    when :black
      :white
    when :white
      :black
    end
  end

  def piece
    @piece ||= board.piece(origin)
  end
end
