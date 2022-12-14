# frozen_string_literal: true

require_relative './../lib/chess'

# rubocop:disable Metrics/BlockLength

RSpec.describe Chess do
  subject(:chess) { described_class.new(board:, player:) }
  let(:board) { instance_double(Board) }
  let(:player) { instance_double(Player) }

  describe '#play' do
    let(:turn) { class_spy(Turn) }

    before :each do
      allow(turn).to receive(:run)
        .with(board, player)
    end

    context 'when game_over? returns true' do
      before do
        allow(chess).to receive(:game_over?)
          .and_return(true)
      end

      it 'does not send move to board' do
        chess.play(turn)

        expect(turn).not_to have_received(:run)
      end
    end

    context 'when game_over? returns false once and then true' do
      before do
        allow(chess).to receive(:game_over?)
          .and_return(false, true)
      end

      it 'sends move with player movement to board once' do
        chess.play(turn)

        expect(turn).to have_received(:run)
          .with(board, player)
          .once
      end
    end

    context 'when game_over? returns false 4 times and then true' do
      before do
        allow(chess).to receive(:game_over?)
          .and_return(false, false, false, false, true)
      end

      it 'sends move with player movement to board 4 times' do
        chess.play(turn)

        expect(turn).to have_received(:run)
          .with(board, player)
          .exactly(4).times
      end
    end
  end

  describe '#game_over?' do
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
