# frozen_string_literal: true

require_relative './../lib/board'

# rubocop:disable Metrics/BlockLength

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#move' do
    context 'when movement origin contains an object' do
      let(:origin) { spy('origin_square') }
      let(:destination) { spy('destination_square') }
      let(:some_piece) { double('Piece') }

      before do
        allow(origin).to receive(:empty)
          .and_return(some_piece)
      end

      it 'sends empty to origin' do
        board.move(origin, destination)

        expect(origin).to have_received(:empty)
      end

      it 'sends fill to destination with origin empty return' do
        board.move(origin, destination)

        expect(destination).to have_received(:fill).with(some_piece)
      end
    end

    context 'when movement origin is empty' do
      let(:origin) { spy('origin_square') }
      let(:destination) { spy('destination_square') }

      before do
        allow(origin).to receive(:empty)
          .and_return(nil)
      end

      it 'sends empty to origin' do
        board.move(origin, destination)

        expect(origin).to have_received(:empty)
      end

      it 'does not send fill to destination' do
        board.move(origin, destination)

        expect(destination).not_to have_received(:fill)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
