# frozen_string_literal: true

require_relative './../lib/chess'
require_relative './../lib/square'

# rubocop:disable Metrics/BlockLength

RSpec.shared_examples 'Movable' do
  subject { described_class.new }

  it 'responds to #origin' do
    expect(subject).to respond_to(:origin)
  end

  xdescribe '#origin' do
    it 'returns an instance of Square' do
      expect(subject.origin).to be_a(Square)
    end
  end

  it 'respond to #destination' do
    expect(subject).to respond_to(:destination)
  end

  xdescribe '#destination' do
    it 'returns an instance of Square' do
      expect(subject.origin).to be_a(Square)
    end
  end
end

RSpec.describe Move do
  it_behaves_like 'Movable'
end

RSpec.describe Chess do
  describe '#run_round' do
    subject(:chess) { described_class.new }
    let(:queried_move) { %i[origin destination] }

    before do
      allow(chess).to receive(:query_move)
        .and_return(queried_move)
      allow(chess).to receive(:execute_move)
        .with(*queried_move)
    end

    it 'sends result of #query_move to #move' do
      expect(chess).to receive(:execute_move)
        .with(*queried_move)
      chess.run_round
    end
  end

  describe '#execute_move' do
    subject(:chess) { described_class.new(board:) }
    let(:board) { instance_double(Board) }
    let(:origin) { instance_double(Square) }
    let(:destination) { instance_double(Square) }

    before do
      allow(board).to receive(:move).with(origin, destination)
    end

    it 'sends #execute_move to board with origin and destination' do
      expect(chess.board).to receive(:move).with(origin, destination)

      chess.execute_move(origin, destination)
    end
  end

  describe '#query_move' do
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

  describe '#valid_move?' do
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
