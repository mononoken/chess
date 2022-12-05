# frozen_string_literal: true

require_relative './../lib/chess'

# rubocop:disable Metrics/BlockLength

RSpec.describe Chess do
  subject(:chess) { described_class.new }

  describe '#play' do
    before do
      allow(chess).to receive(:run_round)
    end

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
    let(:selected_move) { instance_double(Move) }
    before do
      allow(chess).to receive(:execute_move)
    end

    it 'sends #execute_move with selected move once' do
      expect(chess).to receive(:execute_move)
        .with(selected_move).once
      chess.run_round(selected_move)
    end
  end

  # Tests below here may be limiting refactoring and should be private methods.
  # Delete below tests if they fail.

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
    context 'when query_origin and query_destination return' do
      let(:queried_origin) { :some_position }
      let(:queried_destination) { :another_position }

      before do
        allow(chess).to receive(:query_origin)
          .and_return(queried_origin)
        allow(chess).to receive(:query_destination)
          .and_return(queried_destination)
      end

      it 'returns a new Move object' do
        expect(chess.query_move).to be_a_kind_of(Move)
      end

      it 'returns object with #origin equal to query_origin result' do
        query_result = chess.query_move

        expect(query_result.origin).to eq(queried_origin)
      end

      it 'returns object with #destination equal to query_destination result' do
        query_result = chess.query_move

        expect(query_result.destination).to eq(queried_destination)
      end
    end
  end

  describe '#query_origin' do
    before do
      allow(chess).to receive(:pick_origin)
        .and_return('some position')
    end

    context 'when valid_origin? is true' do
      before do
        allow(chess).to receive(:valid_origin?)
          .and_return(true)
      end

      it 'sends #pick_origin once' do
        expect(chess).to receive(:pick_origin)
          .once
        chess.query_origin
      end

      it 'returns result of #pick_origin' do
        picked_origin = chess.pick_origin
        expect(chess.query_origin).to eq(picked_origin)
      end
    end

    context 'when valid_origin? is false once and then true' do
      before do
        allow(chess).to receive(:valid_origin?)
          .and_return(false, true)
      end

      it 'sends #pick_origin twice' do
        expect(chess).to receive(:pick_origin)
          .exactly(2).times
        chess.query_origin
      end

      it 'returns result of #pick_origin' do
        picked_origin = chess.pick_origin
        expect(chess.query_origin).to eq(picked_origin)
      end
    end

    context 'when valid_origin? is false three times and then true' do
      before do
        allow(chess).to receive(:valid_origin?)
          .and_return(false, false, false, true)
      end

      it 'sends #pick_origin four times' do
        expect(chess).to receive(:pick_origin)
          .exactly(4).times
        chess.query_origin
      end

      it 'returns result of #pick_origin' do
        picked_origin = chess.pick_origin
        expect(chess.query_origin).to eq(picked_origin)
      end
    end
  end

  describe '#query_destination' do
    before do
      allow(chess).to receive(:pick_destination)
        .and_return('some position')
    end

    context 'when valid_destination? is true' do
      before do
        allow(chess).to receive(:valid_destination?)
          .and_return(true)
      end

      it 'sends #pick_destination once' do
        expect(chess).to receive(:pick_destination)
          .once
        chess.query_destination
      end

      it 'returns result of #pick_destination' do
        picked_destination = chess.pick_destination
        expect(chess.query_destination).to eq(picked_destination)
      end
    end

    context 'when valid_destination? is false once and then true' do
      before do
        allow(chess).to receive(:valid_destination?)
          .and_return(false, true)
      end

      it 'sends #pick_destination twice' do
        expect(chess).to receive(:pick_destination)
          .exactly(2).times
        chess.query_destination
      end

      it 'returns result of #pick_destination' do
        picked_destination = chess.pick_destination
        expect(chess.query_destination).to eq(picked_destination)
      end
    end

    context 'when valid_destination? is false three times and then true' do
      before do
        allow(chess).to receive(:valid_destination?)
          .and_return(false, false, false, true)
      end

      it 'sends #pick_destination four times' do
        expect(chess).to receive(:pick_destination)
          .exactly(4).times
        chess.query_destination
      end

      it 'returns result of #pick_destination' do
        picked_destination = chess.pick_destination
        expect(chess.query_destination).to eq(picked_destination)
      end
    end
  end

  xdescribe '#valid_origin?' do
    context 'when board returns false to #valid_piece? with origin' do
      it 'returns false'
    end

    context 'when board returns true to #valid_piece? with origin' do
      it 'returns true'
    end
  end
end

# rubocop:enable Metrics/BlockLength
