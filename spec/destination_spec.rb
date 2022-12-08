# frozen_string_literal: true

require_relative './../lib/destination'

# rubocop:disable Metrics/BlockLength

RSpec.describe Destination do
  subject(:destination) { described_class.new }

  describe '#valid?(origin, board)' do
    let(:checks) { instance_double(Array) }

    context 'when checks with origin returns true to all?(true)' do
      before do
        allow(destination).to receive(:checks)
          .and_return(checks)
        allow(checks).to receive(:all?)
          .with(true)
          .and_return(true)
      end

      it 'returns true' do
        expect(destination.valid?).to be(true)
      end
    end

    context 'when checks with origin returns false to all?(true)' do
      before do
        allow(destination).to receive(:checks)
          .and_return(checks)
        allow(checks).to receive(:all?)
          .with(true)
          .and_return(false)
      end

      it 'returns false' do
        expect(destination.valid?).to be(false)
      end
    end
  end

  describe '#checks' do
    it 'sends on_board? and piece_can_move?'
    it 'returns an array'
    context 'when it returns an array' do
      it 'contains only booleans'
    end
  end
end

# rubocop:enable Metrics/BlockLength
