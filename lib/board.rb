# frozen_string_literal: true

# Display squares
class Board
  attr_reader :squares

  def initialize(squares: {})
    @squares = squares
  end

  def move(initial, destination)
    initial = initial.to_sym
    destination = destination.to_sym

    return 'Invalid move' if squares[initial].nil?

    squares[destination] = squares[initial]
    squares[initial] = nil
  end

  def simple_display
    squares.reduce('') { |memo, (key, value)| memo + "#{key}: #{value}\n" }
  end
end
