# frozen_string_literal: true

require_relative '../lib/square'

RSpec.describe Square do
  describe '#simple_display' do
    context 'when square has a position and content' do
      subject(:filled_square) do
        described_class.new(position: :somewhere, content: :something)
      end

      it 'returns str display of position and content' do
        filled_display = 'somewhere: something'

        expect(filled_square.simple_display).to eq(filled_display)
      end
    end

    context 'when square has no content' do
      subject(:empty_square) do
        described_class.new(position: :nowhere, content: nil)
      end

      it 'returns str display of position with no content' do
        empty_display = 'nowhere:'

        expect(empty_square.simple_display).to eq(empty_display)
      end
    end
  end
end
