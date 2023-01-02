# frozen_string_literal: true

class Square
  attr_reader :position, :content

  def initialize(position: nil, content: nil)
    @position = position
    @content = content
  end

  def valid_destination?(origin, destination, boundaries)
    content.valid_destination?(origin, destination, boundaries)
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
    # Implement from Board spec
  end

  private

  attr_writer :content
end
