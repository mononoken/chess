# frozen_string_literal: true

# A square on a chess board.
class Square
  attr_reader :position, :content

  def initialize(position: nil, content: nil)
    @position = position
    @content = content
  end

  def piece_color
    content&.color
  end

  def moves
    content.moves unless empty?
  end

  def simple_display
    "#{position}: #{content}".strip
  end

  def empty?
    content.nil?
  end
end
