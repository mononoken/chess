# frozen_string_literal: true

require_relative './../lib/origin'
require_relative './../lib/board'
require_relative './../lib/player'

# rubocop:disable Metrics/BlockLength

RSpec.describe Origin do
  subject(:origin) { described_class.new(position:, player:, board:) }
  let(:position) { :some_position }
  let(:player) { instance_double(Player) }
  let(:board) { instance_double(Board) }

  describe '#valid?' do
    let(:checks) { instance_double(Array) }

    context 'when checks returns true to all?(true)' do
      before do
        allow(origin).to receive(:checks)
          .and_return(checks)
        allow(checks).to receive(:all?)
          .with(true)
          .and_return(true)
      end

      it 'returns true' do
        expect(origin.valid?).to be(true)
      end
    end

    context 'when checks returns false to all?(true)' do
      before do
        allow(origin).to receive(:checks)
          .and_return(checks)
        allow(checks).to receive(:all?)
          .with(true)
          .and_return(false)
      end

      it 'returns false' do
        expect(origin.valid?).to be(false)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
