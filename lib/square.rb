# frozen_string_literal: true

require_relative './colorable_string'

# Stores piece/content.
class Square
  using ColorableString

  attr_reader :content

  def initialize(content = nil)
    @content = content
  end

  def empty
    previous_content = content
    self.content = nil
    previous_content
  end

  def empty?
    content.nil?
  end

  def fill(item)
    self.content = item
  end

  def piece_color?(color)
    content&.color == color
  end

  def to_s(color = nil)
    if empty?
      '   '
    else
      " #{content.to_s.chomp("\e[0m")} " # Removes early exit code for when BG color is included.
    end.bg_color(color)
  end

  private

  attr_writer :content
end
