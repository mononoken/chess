# frozen_string_literal: true

require_relative '../lib/square'

RSpec.describe Square do
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
