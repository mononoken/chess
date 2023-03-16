# frozen_string_literal: true

require_relative './chess'

puts Chess.instructions

if Chess.prompt_load
  Chess.load_game
else
  Chess.new
end.play
