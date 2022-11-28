# frozen_string_literal: true

# A square on a chess board.
class Square
  attr_reader :position, :content

  def initialize(position:, content: nil)
    @position = position
    @content = content
  end

  def moves
  end

  def simple_display
    "#{position}: #{content}".strip
  end
end
