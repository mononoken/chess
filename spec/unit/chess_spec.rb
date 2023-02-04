# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe Chess do
  subject(:chess) { described_class.new(board:, player:, movement:) }
  let(:player) { instance_double(Player) }
  let(:movement) { double }

  describe '#play' do
    context 'when an invalid destination is selected for a board origin' do
      let(:board) { instance_spy(Board) }
      let(:origin) { [4, 2] }
      let(:destination) { [5, 5] }

      before do
        allow(movement).to receive(:valid_destination?)
          .and_return(false)
      end

      it 'raises error' do
        expect { chess.play(player, origin, destination) }
          .to raise_error(Chess::InvalidDestinationError)
      end

      it 'does not send move to board' do
        chess.play(player, origin, destination) rescue :EXPECTED_ERROR

        expect(board).not_to have_received(:move)
      end
    end

    context 'when a valid destination is selected for a board origin' do
      let(:board) { instance_spy(Board) }
      let(:origin) { [0, 0] }
      let(:destination) { [7, 0] }

      before do
        allow(movement).to receive(:valid_destination?)
          .and_return(true)
      end

      it 'sends board move with origin and destination' do
        chess.play(player, origin, destination)

        expect(board).to have_received(:move)
          .with(origin, destination)
      end
    end
  end
end
