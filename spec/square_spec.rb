# frozen_string_literal: true

require_relative './../lib/square'

# rubocop:disable Metrics/BlockLength

RSpec.describe Square do
  subject(:square) { described_class.new }

  describe 'empty' do
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
end

# rubocop:enable Metrics/BlockLength
