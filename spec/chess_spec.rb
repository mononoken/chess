# frozen_string_literal: true

require_relative './../lib/chess'

# rubocop:disable Metrics/BlockLength

RSpec.describe Chess do
  subject(:chess) { described_class.new(board:, player:) }

  describe '#play' do
    let(:board) { spy('board') }
    let(:player) { instance_double(Player) }

    context 'when game_over? returns true' do
      before do
        allow(chess).to receive(:game_over?)
          .and_return(true)
      end

      it 'does not send move to board' do
        chess.play

        expect(board).not_to have_received(:move)
      end
    end

    context 'when game_over? returns false once and then true' do
      before do
        allow(chess).to receive(:game_over?)
          .and_return(false, true)
        allow(player).to receive(:movement)
      end

      it 'sends move with player movement to board once' do
        chess.play

        expect(board).to have_received(:move)
          .with(player.movement)
          .once
      end
    end

    context 'when game_over? returns false 4 times and then true' do
      before do
        allow(chess).to receive(:game_over?)
          .and_return(false, false, false, false, true)
        allow(player).to receive(:movement)
      end

      it 'sends move with player movement to board 4 times' do
        chess.play

        expect(board).to have_received(:move)
          .with(player.movement)
          .exactly(4).times
      end
    end
  end

  describe '#game_over?' do
    let(:board) { instance_double(Board) }
    let(:player) { instance_double(Player) }

    context 'when player returns true to checkmate? and false to stalemate?' do
      before do
        allow(player).to receive(:checkmate?)
          .and_return(true)
        allow(player).to receive(:stalemate?)
          .and_return(false)
      end

      it 'returns true' do
        expect(chess.game_over?).to be(true)
      end
    end

    context 'when player returns true to stalemate? and false to checkmate?' do
      before do
        allow(player).to receive(:stalemate?)
          .and_return(true)
        allow(player).to receive(:checkmate?)
          .and_return(false)
      end

      it 'returns true' do
        expect(chess.game_over?).to be(true)
      end
    end

    context 'when player returns false to checkmate? and stalemate?' do
      before do
        allow(player).to receive(:checkmate?)
          .and_return(false)
        allow(player).to receive(:stalemate?)
          .and_return(false)
      end

      it 'returns false' do
        expect(chess.game_over?).to be(false)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
