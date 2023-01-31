# frozen_string_literal: true

require_relative './../../lib/players'

RSpec.describe Players do
  subject(:players) { described_class.new(player1:, player2:) }
  let(:player1) { instance_double(Player) }
  let(:player2) { instance_double(Player) }

  xdescribe '#set_current' do
    context 'when current player is not set' do
      it 'sets current player to white player' do
        current_player = players.current

        expect { players.set_current }
          .to change { current_player.color }
          .from(nil)
          .to(:white)
      end
    end
  end

  describe '#color' do
    context 'when one of all players has selected color attribute' do
      let(:selected_color) { :white }

      before do
        allow(player1).to receive(:color)
          .and_return(selected_color)
        allow(player2).to receive(:color)
          .and_return(:orange)
      end

      it 'returns that player' do
        expect(players.color(selected_color)).to be(player1)
      end
    end

    context 'when none of the players has selected color attribute' do
      let(:selected_color) { :blue }

      before do
        allow(player1).to receive(:color)
          .and_return(:purple)
        allow(player2).to receive(:color)
          .and_return(:yellow)
      end

      it 'returns nil' do
        expect(players.color(selected_color)).to be(nil)
      end
    end
  end
end
