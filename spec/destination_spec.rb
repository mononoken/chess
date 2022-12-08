# frozen_string_literal: true

require_relative './../lib/destination'
require_relative './../lib/origin'
require_relative './../lib/board'

# rubocop:disable Metrics/BlockLength

RSpec.describe Destination do
  subject(:destination) { described_class.new(position:, origin:) }
  let(:position) { :some_position }
  let(:origin) { instance_double(Origin) }

  xdescribe '#valid?' do
    context 'when on_board? position_is_reachable? return true' do
      it 'returns true'
    end

    context 'when on_board? or position_is_reachable? return false' do
      it 'returns false'
    end

    context 'when on_board? and position_is_reachable? return false' do
      it 'returns false'
    end
  end

  describe '#position_is_reachable?' do
    context 'when piece returns true to moves?' do
      it 'returns true'
    end

    context 'when piece returns false to moves?' do
      it 'returns false'
    end
  end

  describe '#on_board?' do
    context `when origin's board returns true to position_exists? with position` do
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

    context `when origin's board returns false to position_exists? with position` do
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
