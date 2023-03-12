# frozen_string_literal: true

require_relative './chess'

if Chess.prompt_load
  Chess.load_game
else
  Chess.new
end.play
