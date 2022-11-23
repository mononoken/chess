# frozen_string_literal: true

# Create Squares for Chess Board.
class Squares
  def initialize(coordinates = chess_coordinates)
    @coordinates = coordinates
  end

  def chess_positions
    chess_coordinates.map { |coordinate| to_position(coordinate) }
  end

  def to_position(coordinate)
    "#{to_file(coordinate[0])}#{to_rank(coordinate[1])}".to_sym
  end

  # Should this be private?
  def chess_coordinates
    (0..7).to_a.repeated_permutation(2).to_a
  end

  private

  def to_file(coordinate)
    case coordinate
    when 0
      'a'
    when 1
      'b'
    when 2
      'c'
    when 3
      'd'
    when 4
      'e'
    when 5
      'f'
    when 6
      'g'
    when 7
      'h'
    end
  end

  def to_rank(coordinate)
    case coordinate
    when 0
      '1'
    when 1
      '2'
    when 2
      '3'
    when 3
      '4'
    when 4
      '5'
    when 5
      '6'
    when 6
      '7'
    when 7
      '8'
    end
  end
end
