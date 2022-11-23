# frozen_string_literal: true

require_relative '../lib/square'

# rubocop:disable Metrics/BlockLength

RSpec.describe Square do
  describe '#position' do
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
  end

  describe '#add_content' do
    context 'when content is currently empty' do
      subject(:empty_square) do
        described_class.new(coordinate: 'xy', content: nil)
      end
      let(:thing) { 'something' }

      it 'changes content to new content' do
        expect { empty_square.add_content(thing) }.to \
          change(empty_square, :content)
          .to(thing)
      end
    end

    context 'when content is currently full' do
      subject(:full_square) do
        described_class.new(coordinate: 'xy', content: 'original')
      end
      let(:new_thing) { 'new' }

      it 'changes content to new content' do
        expect { full_square.add_content(new_thing) }.to \
          change(full_square, :content)
          .to(new_thing)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
