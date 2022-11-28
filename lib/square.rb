# frozen_string_literal: true

require_relative './piece'

# A square on a chess board.
class Square
  attr_reader :position, :content

  def initialize(position: nil, content: nil)
    @position = position
    @content = content
  end

  def moves
    content.moves unless empty?
  end

  def simple_display
    "#{position}: #{content}".strip
  end

  private

  def empty?
    content.nil?
  end
end
