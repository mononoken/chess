# frozen_string_literal: true

require_relative "chess"
require_relative "chess_controller"

puts ChessController.instructions

if Chess.prompt_load
  ChessController.new(Chess.load_game)
else
  ChessController.new(Chess.new)
end.play
