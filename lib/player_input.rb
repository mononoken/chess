# frozen_string_literal: true

# Manage inputs, as strings, that a player can send to the game.
class PlayerInput
  def self.player_origin(board, players)
    puts "Enter origin using algebraic coordinates (e.g. d2)"
    puts "Or enter 's' to save game."
    loop do
      self.input = gets.chomp.downcase

      return save_game if input == "s"

      origin = board.positions.position(input.to_sym)

      return origin if origin.valid_origin?(players.current, board)

      puts "Invalid origin! Please enter a valid origin:"
    end
  end

  def self.player_destination(origin, board)
    puts "Enter destination using algebraic coordinates (e.g. d4)"
    loop do
      self.input = gets.chomp
      destination = board.positions.position(input.to_sym)

      return destination if destination.valid_destination?(origin, board)

      puts "Invalid destination! Please enter a valid destination:"
    end
  end

  attr_reader :input

  def initialize(input = gets.chomp.downcase)
    @input = input
  end
end
