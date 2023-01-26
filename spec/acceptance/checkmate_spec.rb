# frozen_string_literal: true

require_relative './../../lib/chess'
# require all files in pieces
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob("#{project_root}/../../lib/pieces/*", &method(:require_relative))

RSpec.describe 'Checkmate Game API' do
  context "when game is in Fool's mate" do
    let(:board) { Board.new() }

    let(:player) { Player.new }

    let(:game) { Chess.new(board:, player:) }

    it 'returns true to checkmate?'
  end
end
