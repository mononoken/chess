# frozen_string_literal: true

require_relative './../lib/chess'

# rubocop:disable Metrics/BlockLength

RSpec.describe Chess do
  subject(:chess) { described_class.new }
  describe '#play' do
    context 'when game_over? returns true' do
      it 'does not send run_round'
    end

    context 'when game_over? returns false once and then true' do
      it 'sends run_round once'
    end

    context 'when game_over? returns false 4 times and then true' do
      it 'sends run_round 4 times'
    end
  end
end

# rubocop:enable Metrics/BlockLength
