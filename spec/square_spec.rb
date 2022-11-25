# frozen_string_literal: true

require_relative '../lib/square'

# rubocop:disable Metrics/BlockLength

RSpec.describe Square do
  xdescribe '#position' do
    subject(:square) { described_class.new(coordinate: coordinate) }

    context 'when coordinate is [0, 0]' do
      let(:coordinate) { [0, 0] }
      it 'returns position :a1 as a symbol' do
        position = :a1

        expect(square.position).to eq(position)
      end
    end

    context 'when coordinate is [4, 7]' do
      let(:coordinate) { [4, 7] }
      it 'returns position :e8 as a symbol' do
        position = :e8

        expect(square.position).to eq(position)
      end
    end

    context 'when coordinate is [99, 99]' do
      let(:coordinate) { [99, 99] }
      it 'returns nil' do
        expect(square.position).to be_nil
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
