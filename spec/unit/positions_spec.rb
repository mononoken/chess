# frozen_string_literal: true

require_relative './../../lib/positions'

RSpec.describe Positions do
  subject(:positions) { described_class.new(files:) }
  let(:files) { double }

  describe '#from_square' do
    context 'when @all contains an object with square attribute that matches given square' do
      let(:selected_square) { double }
      let(:matching_position) { double }

      before do
        allow(matching_position).to receive(:square)
          .and_return(selected_square)
        allow(positions).to receive(:all)
          .and_return([matching_position])
      end

      it 'returns that position' do
        result = positions.from_square(selected_square)

        expect(result).to eq(matching_position)
      end
    end

    context 'when @all does not contain an object with square attribute that matches given square' do
      let(:selected_square) { double }

      before do
        allow(positions).to receive(:all)
          .and_return([])
      end

      it 'returns nil' do
        result = positions.from_square(selected_square)

        expect(result).to be(nil)
      end
    end
  end
end
