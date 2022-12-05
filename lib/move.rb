# frozen_string_literal: true

class Move
  attr_reader :origin, :destination

  def initialize(origin:, destination:)
    @origin = origin
    @destination = destination
  end
end
