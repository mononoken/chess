# frozen_string_literal: true

require_relative '../lib/square'

RSpec.describe Square do
  describe '#add_content' do
    context 'when content is currently empty' do
      it 'changes content to new content'
      it 'returns `move` message'
    end

    context 'when content is currently full' do
      it 'changes content to new content'
      it 'returns `capture` message'
    end
  end
end
