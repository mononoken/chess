# frozen_string_literal: true

require_relative './../../lib/board'
require_relative './../../lib/rook'

# rubocop:disable Metrics/BlockLength

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#move' do
    subject(:board) { described_class.new(squares) }
    let(:squares) { instance_double(Array) }
    let(:column) { instance_double(Array) }
    let(:origin_square) { instance_spy(Square) }
    let(:destination_square) { instance_spy(Square) }

    let(:origin) { [0, 0] }
    let(:destination) { [0, 6] }

    before :each do
      allow(squares).to receive(:[])
        .with(origin[0])
        .and_return(column)
      allow(column).to receive(:[])
        .with(origin[1])
        .and_return(origin_square)

      allow(squares).to receive(:[])
        .with(destination[0])
        .and_return(column)
      allow(column).to receive(:[])
        .with(destination[1])
        .and_return(destination_square)
    end

    context 'when origin square is not empty' do
      let(:rook) { instance_double(Rook) }

      before do
        allow(origin_square).to receive(:empty?)
          .and_return(false)
        # empty acts like pop and returns content that was removed.
        allow(origin_square).to receive(:empty)
          .and_return(rook)
      end

      it 'sends empty to origin square' do
        board.move(origin, destination)

        expect(origin_square).to have_received(:empty)
      end

      it 'sends fill to destination square with origin content' do
        board.move(origin, destination)

        expect(destination_square).to have_received(:fill)
          .with(rook)
      end
    end

    context 'when origin square is empty' do
      before do
        allow(origin_square).to receive(:empty?)
          .and_return(true)
      end

      it 'raises error' do
        expect { board.move(origin, destination) }.to raise_error
      end

      it 'does not send empty to origin square' do
        begin
          board.move(origin, destination)
        rescue Board::EmptyOriginError
          nil
        end

        expect(origin_square).not_to have_received(:empty)
      end

      it 'does not send fill to destination square' do
        begin
          board.move(origin, destination)
        rescue Board::EmptyOriginError
          nil
        end

        expect(destination_square).not_to have_received(:fill)
      end
    end
  end

  describe '#populate' do
    context 'when rook is placed at 0, 0' do
      let(:rook) { instance_double(Rook) }

      it 'changes square content at [0][0] to rook' do
        x = 0
        y = 0
        position = [x, y]

        square = board.squares[x][y]

        board.populate(rook, position)

        expect(square.content).to eq(rook)
      end
    end

    context 'when rook is placed at 4, 2' do
      let(:rook) { instance_double(Rook) }

      it 'changes square content at [4][2] to rook' do
        x = 4
        y = 2
        position = [x, y]

        square = board.squares[x][y]

        board.populate(rook, position)

        expect(square.content).to eq(rook)
      end
    end
  end

  describe '#square' do
    it 'blanks'
  end
end

# rubocop:enable Metrics/BlockLength
