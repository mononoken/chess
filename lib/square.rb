# frozen_string_literal: true

# A square on a chess board.
class Square
  attr_reader :coordinate, :content

  def initialize(coordinate:, content: nil)
    @coordinate = coordinate
    @content = content
  end

  def add_content(content)
    @content = content
  end
end
