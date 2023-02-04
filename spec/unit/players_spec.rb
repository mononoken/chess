# frozen_string_literal: true

require_relative './../../lib/players'

RSpec.describe Players do
  subject(:players) { described_class.new }

  describe '#current' do
    context 'when players is initialized' do
      it 'returns :white' do
        expect(players.current).to eq(:white)
      end
    end

    context 'when #swap is sent to players once after initialize' do
      before do
        players.swap
      end

      it 'returns :black' do
        expect(players.current).to eq(:black)
      end
    end

    context 'when #swap is sent to players twice after initialize' do
      before do
        2.times do
          players.swap
        end
      end

      it 'returns :white' do
        expect(players.current).to eq(:white)
      end
    end
  end
end
