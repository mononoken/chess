# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe Chess do
  subject(:chess) { described_class.new(board:) }

  describe '#send_move' do
    context 'when an invalid destination is selected for a board origin' do
      let(:board) { instance_spy(Board) }
      let(:origin) { instance_double(Position) }
      let(:destination) { instance_double(Position) }

      before do
        allow(destination).to receive(:valid_destination?)
          .with(origin, board)
          .and_return(false)
      end

      it 'raises error' do
        expect { chess.send_move(origin, destination) }
          .to raise_error(Chess::InvalidDestinationError)
      end

      it 'does not send move to board' do
        chess.send_move(origin, destination) rescue :EXPECTED_ERROR

        expect(board).not_to have_received(:move)
      end
    end

    context 'when a valid destination is selected for a board origin' do
      let(:board) { instance_spy(Board) }
      let(:origin) { instance_double(Position) }
      let(:destination) { instance_double(Position) }

      before do
        allow(destination).to receive(:valid_destination?)
          .with(origin, board)
          .and_return(true)
      end

      it 'sends board move with origin and destination' do
        chess.send_move(origin, destination)

        expect(board).to have_received(:move)
          .with(origin, destination)
      end
    end
  end
end
