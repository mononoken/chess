# frozen_string_literal: true

require_relative "chess"
require_relative "chess_controller"

# Clear terminal
system("clear") || system("cls")

puts ChessController.instructions

chess = if Chess.prompt_load
  Chess.load_game
else
  Chess.new
end

ChessController.play(chess)
