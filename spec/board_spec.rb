# frozen_string_literal: true

require_relative './../lib/board'

# rubocop:disable Metrics/BlockLength

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    context 'when width is 3 and height is 5' do
      subject(:board_3x5) { described_class.new(width: 3, height: 5) }
      let(:squares) { board_3x5.squares }

      it 'sets squares length to 3' do
        expect(squares.length).to eq(3)
      end

      it 'sets squares to contain only arrays' do
        types = squares.map(&:class).uniq[0]

        expect(types).to be(Array)
      end

      it 'sets each array in squares to length 5' do
        lengths = squares.map(&:length).uniq[0]

        expect(lengths).to eq(5)
      end
    end

    context 'when width is 8 and height is 8' do
      subject(:board_8x8) { described_class.new(width: 8, height: 8) }
      let(:squares) { board_8x8.squares }

      it 'sets squares length to 8' do
        expect(squares.length).to eq(8)
      end

      it 'sets squares to contain only arrays' do
        types = squares.map(&:class).uniq[0]

        expect(types).to be(Array)
      end

      it 'sets each array in squares to length 8' do
        lengths = squares.map(&:length).uniq[0]

        expect(lengths).to eq(8)
      end
    end
  end

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
