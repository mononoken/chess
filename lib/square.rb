# frozen_string_literal: true

# A square on a chess board.
class Square
  attr_reader :position, :coordinate, :color
  attr_accessor :content

  def initialize(position:, coordinate:, content: nil, color: nil)
    @position = position
    @coordinate = coordinate
    @content = content
    @color = color
  end

  # def position
  #   @position ||= if coordinate_outside_range?
  #                   nil
  #                 else
  #                   "#{to_file(coordinate[0])}#{to_rank(coordinate[1])}".to_sym
  #                 end
  # end

  # private

  # def coordinate_outside_range?
  #   coordinate[0] < 0 || coordinate[0] > 7 || coordinate[1] < 0 || coordinate[1] > 7
  # end

  # def to_file(coordinate)
  #   case coordinate
  #   when 0
  #     'a'
  #   when 1
  #     'b'
  #   when 2
  #     'c'
  #   when 3
  #     'd'
  #   when 4
  #     'e'
  #   when 5
  #     'f'
  #   when 6
  #     'g'
  #   when 7
  #     'h'
  #   end
  # end

  # def to_rank(coordinate)
  #   case coordinate
  #   when 0
  #     '1'
  #   when 1
  #     '2'
  #   when 2
  #     '3'
  #   when 3
  #     '4'
  #   when 4
  #     '5'
  #   when 5
  #     '6'
  #   when 6
  #     '7'
  #   when 7
  #     '8'
  #   end
  # end
end
