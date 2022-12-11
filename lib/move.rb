# frozen_string_literal: true

class Move
  attr_reader :origin, :destination

  def initialize(origin:, destination:)
    @origin = origin
    @destination = destination
  end
end

# Methods moved from Chess private
class Chess
  def verified_origin(player = current_player)
    loop do
      origin = origin_choice(player)
      break origin if origin.valid?
    end
  end

  def origin_choice(player)
    Origin.new(position: verified_position(player), player:, board:)
  end

  def verified_position(player)
    loop do
      position = origin_input(player).to_sym
      break position if valid_position?(position)

      # Raise invalid position error
    end
  end

  def valid_position?(position)
    board.valid_position(position)
  end

  def origin_input(player)
    puts "#{player}, pick a piece to move by typing its position."
    player_input
  end

  def verified_destination(player = current_player)
    loop do
      destination = destination_choice(player)
      break destination if destination.valid?
    end
  end

  def destination_choice(player)
    Destination.new(position: verified_position(player), player:, board:)
  end

  def pick_destination(player)
    puts "#{player}, pick where you want to move piece by typing the position."
    player_input
  end

  def player_input
    gets.chomp.downcase
  end
end