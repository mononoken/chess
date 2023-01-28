# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe 'Full game played API' do
  xcontext "when game receives moves for the Opera game" do
    let(:game) { Chess.new(board:, player:) }

    before do
    end

    it 'board state returns expected end of the Opera Game'

    it 'returns checkmate for black'

    it 'returns expected winner'
  end
end
