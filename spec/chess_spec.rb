# frozen_string_literal: true

require_relative './../lib/chess'

# rubocop:disable Metrics/BlockLength

RSpec.describe Chess do
  subject(:chess) { described_class.new }

  describe '#play' do
    context 'when game_over? is true' do
      before do
        allow(chess).to receive(:game_over?)
          .and_return(true)
      end

      it 'sends run_round once' do
        expect(chess).to receive(:run_round)
          .once
        chess.play
      end
    end

    context 'when game_over? is false twice and then true' do
      before do
        allow(chess).to receive(:game_over?)
          .and_return(false, false, true)
      end

      it 'sends run_round three times' do
        expect(chess).to receive(:run_round)
          .exactly(3).times
        chess.play
      end
    end
  end

  describe '#game_over?' do
    pending 'Pending check and checkmate implementation'
  end

  describe '#run_round' do
    before do
      allow(chess).to receive(:query_move)
    end

    it 'sends #query_move once' do
      expect(chess).to receive(:query_move).once
      chess.run_round
    end

    it 'sends result of #query_move to #execute_move' do
      queried_move = chess.query_move

      expect(chess).to receive(:execute_move)
        .with(queried_move)
      chess.run_round
    end
  end

  describe '#execute_move' do
    subject(:chess) { described_class.new(board:) }
    let(:board) { instance_double(Board) }
    let(:move) { instance_double(Move) }

    before do
      allow(board).to receive(:execute_move).with(move)
    end

    it 'sends #execute_move to board with injected Move object' do
      expect(chess.board).to receive(:execute_move).with(move)

      chess.execute_move(move)
    end
  end

  describe '#query_move' do
    before do
      allow(chess).to receive(:pick_move)
        .and_return('some type of move')
    end

    context 'when valid_move? is true' do
      before do
        allow(chess).to receive(:valid_move?)
          .and_return(true)
      end

      it 'sends #pick_move once' do
        expect(chess).to receive(:pick_move)
          .once
        chess.query_move
      end

      it 'returns result of #pick_move' do
        picked_move = chess.pick_move
        expect(chess.query_move).to eq(picked_move)
      end
    end

    context 'when valid_move? is false once and then true' do
      before do
        allow(chess).to receive(:valid_move?)
          .and_return(false, true)
      end

      it 'sends #pick_move twice' do
        expect(chess).to receive(:pick_move)
          .exactly(2).times
        chess.query_move
      end

      it 'returns result of #pick_move' do
        picked_move = chess.pick_move
        expect(chess.query_move).to eq(picked_move)
      end
    end

    context 'when valid_move? is false three times and then true' do
      before do
        allow(chess).to receive(:valid_move?)
          .and_return(false, false, false, true)
      end

      it 'sends #pick_move four times' do
        expect(chess).to receive(:pick_move)
          .exactly(4).times
        chess.query_move
      end

      it 'returns result of #pick_move' do
        picked_move = chess.pick_move
        expect(chess.query_move).to eq(picked_move)
      end
    end
  end

  describe '#valid_move?' do
    let(:movement_object) { double }

    context 'when move returns true to #valid?' do
      before do
        allow(movement_object).to receive(:valid?)
          .and_return(true)
      end

      it 'returns true' do
        expect(chess.valid_move?(movement_object)).to be(true)
      end
    end

    context 'when move returns false to #valid?' do
      before do
        allow(movement_object).to receive(:valid?)
          .and_return(false)
      end

      it 'returns false' do
        expect(chess.valid_move?(movement_object)).to be(false)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
