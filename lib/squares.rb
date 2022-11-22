# frozen_string_literal: true

class Squares
  attr_reader :positions

  def initialize
    @positions = create_board
  end

  def create_coordinates
    coordinates = Array.new.push([0,0])
    x = 0
    y = 0

    loop do
      if y == 7
        x += 1
        y = 0
      else
        y += 1
      end

      coordinates.push([x, y])
      break if x == 7 && y ==7
    end
    coordinates
  end

  def create_board
    create_coordinates.map { |coordinate| Square.new(coordinate) }
  end

  def position(coordinate)
    @positions.find { |position| position.coordinate == coordinate }
  end
end
