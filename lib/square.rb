# frozen_string_literal: true

class Square
  attr_accessor :content

  def initialize(content = nil)
    @content = content
  end

  def empty
    previous_content = content
    self.content = nil
    previous_content
  end

  def empty?
    # Board spec
  end

  def fill(item)
    self.content = item
  end
end
