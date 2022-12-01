# frozen_string_literal: true

require_relative '../lib/square'
require_relative '../lib/piece'

# rubocop:disable Metrics/BlockLength

RSpec.describe Square do
  describe '#piece_color' do
    context 'when square is empty' do
      subject(:empty_square) { described_class.new(content: nil) }

      it 'returns nil' do
        expect(empty_square.piece_color).to be_nil
      end
    end

    context 'when square has content with color property :red' do
      subject(:occupied_square) { described_class.new(content: colorful_thing) }
      let(:colorful_thing) { double }

      before do
        allow(colorful_thing).to receive(:color)
          .and_return(:red)
      end

      it 'returns :red' do
        expect(occupied_square.piece_color).to eq(:red)
      end
    end
  end

  describe '#moves' do
    context 'when square has a piece in content' do
      subject(:square) { described_class.new(content: some_piece) }
      let(:some_piece) { instance_double(Piece) }
      let(:valid_moves) { %i[there over_there] }

      before do
        allow(some_piece).to receive(:moves)
          .and_return(valid_moves)
      end

      it 'returns array of valid moves for piece' do
        expect(square.moves).to eq(valid_moves)
      end
    end

    context 'when square is empty' do
      subject(:square) { described_class.new(content: nil) }

      it 'returns nil' do
        expect(square.moves).to be_nil
      end
    end
  end

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

# rubocop:enable Metrics/BlockLength
