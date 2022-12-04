# frozen_string_literal: true

require_relative './../lib/chess'
require_relative './../lib/square'

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
    let(:move) { double('Move') }

    before do
      allow(board).to receive(:execute_move).with(move)
    end

    it 'sends #execute_move to board with injected move' do
      expect(chess.board).to receive(:execute_move).with(move)

      chess.execute_move(move)
    end
  end

  xdescribe '#query_move' do
    subject(:chess) { described_class.new }

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

      it 'returns instance of Move' do
        expect(chess.query_move).to be_a Move
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

      it 'returns instance of Move' do
        expect(chess.query_move).to be_a Move
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

      it 'returns instance of Move' do
        expect(chess.query_move).to be_a Move
      end
    end
  end

  xdescribe '#valid_move?' do
    subject(:chess) { described_class.new(board:) }
    let(:board) { instance_double(Board) }
    let(:origin) { instance_double(Square) }
    let(:destination) { instance_double(Square) }
    context 'when valid_origin? and valid_destination? are true' do
      before do
        allow(chess).to receive(:valid_origin?)
          .with(origin)
          .and_return(true)
        allow(chess).to receive(:valid_destination?)
          .with(destination)
          .and_return(true)
      end
      it 'returns true' do
        expect(chess.valid_move?(origin, destination)).to be(true)
      end
    end

    context 'when valid_origin? is false' do
      it 'returns false'
    end

    context 'when valid_destination? is false' do
      it 'returns false'
    end
  end
end

# rubocop:enable Metrics/BlockLength
