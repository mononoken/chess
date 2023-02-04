# frozen_string_literal: true

# Track the current player color for Chess.
class Players
  attr_reader :current

  def initialize(current = :white)
    @current = current
  end

  def swap
    self.current = current == :white ? :black : :white
  end

  private

  attr_writer :current
end
