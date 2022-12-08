# frozen_string_literal: true

require_relative './../lib/destination'
require_relative './../lib/origin'
require_relative './../lib/board'
require_relative './../lib/piece'

# rubocop:disable Metrics/BlockLength

RSpec.describe Destination do
  subject(:destination) { described_class.new(position:, origin:) }
  let(:position) { :some_position }
  let(:origin) { instance_double(Origin) }

  describe '#valid?' do
    context 'when on_board? position_is_reachable? return true' do
      before do
        allow(destination).to receive(:on_board?)
          .and_return(true)
        allow(destination).to receive(:position_is_reachable?)
          .and_return(true)
      end

      it 'returns true' do
        expect(destination.valid?).to be(true)
      end
    end

    context 'when on_board? or position_is_reachable? return false' do
      before do
        first_boolean = [true, false].sample
        allow(destination).to receive(:on_board?)
          .and_return(first_boolean)
        allow(destination).to receive(:position_is_reachable?)
          .and_return(!first_boolean)
      end

      it 'returns false' do
        expect(destination.valid?).to be(false)
      end
    end

    context 'when on_board? and position_is_reachable? return false' do
      before do
        allow(destination).to receive(:on_board?)
          .and_return(false)
        allow(destination).to receive(:position_is_reachable?)
          .and_return(false)
      end

      it 'returns false' do
        expect(destination.valid?).to be(false)
      end
    end
  end

  describe '#position_is_reachable?' do
    context 'when origin piece returns true to valid_move? with position' do
      let(:piece) { instance_double(Piece) }
      before do
        allow(origin).to receive(:piece)
          .and_return(piece)
        allow(piece).to receive(:valid_move?)
          .with(position)
          .and_return(true)
      end

      it 'returns true' do
        expect(destination.position_is_reachable?).to be(true)
      end
    end

    context 'when origin piece returns false to valid_move? with position' do
      let(:piece) { instance_double(Piece) }
      before do
        allow(origin).to receive(:piece)
          .and_return(piece)
        allow(piece).to receive(:valid_move?)
          .with(position)
          .and_return(false)
      end

      it 'returns false' do
        expect(destination.position_is_reachable?).to be(false)
      end
    end
  end

  describe '#on_board?' do
    context 'when origin board returns true to position_exists? with position' do
      let(:board) { instance_double(Board) }
      before do
        allow(origin).to receive(:board)
          .and_return(board)
        allow(board).to receive(:position_exists?)
          .with(position)
          .and_return(true)
      end

      it 'returns true' do
        expect(destination.on_board?).to be(true)
      end
    end

    context 'when origin board returns false to position_exists? with position' do
      let(:board) { instance_double(Board) }
      before do
        allow(origin).to receive(:board)
          .and_return(board)
        allow(board).to receive(:position_exists?)
          .with(position)
          .and_return(false)
      end

      it 'returns false' do
        expect(destination.on_board?).to be(false)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
