# frozen_string_literal: true

require_relative './../lib/origin'
require_relative './../lib/board'

# rubocop:disable Metrics/BlockLength

RSpec.describe Origin do
  subject(:origin) { described_class.new(position:, board:) }
  let(:position) { :some_position }
  let(:board) { instance_double(Board) }

  describe '#valid?' do
    let(:all_checks) { instance_double(Array) }

    context 'when all_checks returns true to all?(true)' do
      before do
        allow(origin).to receive(:all_checks)
          .and_return(all_checks)
        allow(all_checks).to receive(:all?)
          .with(true)
          .and_return(true)
      end

      it 'returns true' do
        expect(origin.valid?).to be(true)
      end
    end

    context 'when all_checks returns false to all?(true)' do
      before do
        allow(origin).to receive(:all_checks)
          .and_return(all_checks)
        allow(all_checks).to receive(:all?)
          .with(true)
          .and_return(false)
      end

      it 'returns false' do
        expect(origin.valid?).to be(false)
      end
    end
  end

  describe '#has_moves?' do
  end

  describe '#player_owns?' do
  end

  describe '#piece?' do
    let(:square) { double(Square) }

    context 'when square returns false to empty?' do
      before do
        allow(origin).to receive(:square)
          .and_return(square)
        allow(square).to receive(:empty?)
          .and_return(false)
      end

      it 'returns true' do
        result = origin.piece?

        expect(result).to be(true)
      end
    end

    context 'when square returns true to empty?' do
      before do
        allow(origin).to receive(:square)
          .and_return(square)
        allow(square).to receive(:empty?)
          .and_return(true)
      end

      it 'returns false' do
        result = origin.piece?

        expect(result).to be(false)
      end
    end
  end

  describe '#square' do
    context 'when board calls square with position and returns nil' do
      before do
        allow(board).to receive(:square)
          .with(position)
          .and_return(nil)
      end

      it 'returns nil' do
        expect(origin.square).to be(nil)
      end
    end

    context 'when board calls square with position and returns square object' do
      let(:matching_square) { instance_double(Square) }

      before do
        allow(board).to receive(:square)
          .with(position)
          .and_return(matching_square)
      end

      it 'returns the square object' do
        expect(origin.square).to eq(matching_square)
      end
    end
  end

  describe '#on_board?' do
    subject(:origin) { described_class.new(position:, board:) }

    context 'when board returns true to position_exists? with position' do
      before do
        allow(board).to receive(:position_exists?)
          .with(position)
          .and_return(true)
      end

      it 'returns true' do
        expect(origin.on_board?).to be(true)
      end
    end

    context 'when board returns false to position_exists? with position' do
      before do
        allow(board).to receive(:position_exists?)
          .with(position)
          .and_return(false)
      end

      it 'returns false' do
        expect(origin.on_board?).to be(false)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
