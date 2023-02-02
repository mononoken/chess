# frozen_string_literal: true

require_relative './../../lib/square'
require_relative './../../lib/pieces/piece'

RSpec.describe Square do
  subject(:square) { described_class.new }

  describe '#empty?' do
    context 'when Square content is nil' do
      subject(:square) { described_class.new(nil) }

      it 'returns true' do
        expect(square.empty?).to be(true)
      end
    end

    context 'when Square content is an object' do
      let(:object) { double }

      before do
        square.fill(object)
      end

      it 'returns false' do
        expect(square.empty?).to be(false)
      end
    end
  end

  describe '#empty' do
    context 'when content has some value' do
      subject(:square) { described_class.new(some_content) }
      let(:some_content) { double }

      it 'sets square content to nil' do
        square.empty

        expect(square.content).to be(nil)
      end

      it 'returns the previous value of content' do
        expect(square.empty).to eq(some_content)
      end
    end
  end

  describe '#fill' do
    context 'when square content is nil' do
      subject(:square) { described_class.new(nil) }
      let(:item) { double }

      it 'sets square content to item' do
        expect { square.fill(item) }
          .to change { square.content }
          .to(item)
      end
    end

    context 'when square content contains something' do
      subject(:square) { described_class.new(previous_item) }
      let(:previous_item) { double }
      let(:new_item) { double }

      it 'sets square content from previous item to new item' do
        expect { square.fill(new_item) }
          .to change { square.content }
          .from(previous_item)
          .to(new_item)
      end
    end
  end

  describe '#piece_color?' do
    context 'when content color is equal to selected color' do
      subject(:square) { described_class.new(content) }
      let(:content) { double }
      let(:selected_color) { :purple }

      before do
        allow(content).to receive(:color)
          .and_return(selected_color)
      end

      it 'returns true' do
        result = square.piece_color?(selected_color)

        expect(result).to be(true)
      end
    end

    context 'when content color is not equal to selected color' do
      subject(:square) { described_class.new(content) }
      let(:content) { double }
      let(:selected_color) { :purple }

      before do
        allow(content).to receive(:color)
          .and_return(:different_color)
      end

      it 'returns true' do
        result = square.piece_color?(selected_color)

        expect(result).to be(false)
      end
    end
  end
end
