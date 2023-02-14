# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe Chess do
  subject(:chess) { described_class.new(board:, movement:) }
  let(:movement) { class_double(Movement) }

  xdescribe '#valid_algebraic?' do
    let(:board) { instance_double(Board) }
    let(:origin) { double }
    let(:origin_algebraic) { double }
    let(:array_of_algebraic_positions) { instance_double(Array) }

    before :each do
      allow(board).to receive(:positions_algebraic)
        .and_return(array_of_algebraic_positions)

      allow(origin).to receive(:algebraic)
        .and_return(origin_algebraic)
    end

    context 'when origin is in board.positions_algebraic' do
      before do
        allow(array_of_algebraic_positions).to receive(:any?)
          .with(origin_algebraic)
          .and_return(true)
      end

      it 'returns true' do
        result = chess.valid_algebraic?(origin)

        expect(result).to be(true)
      end
    end

    context 'when origin is not in board.positions_algebraic' do
      before do
        allow(array_of_algebraic_positions).to receive(:any?)
          .with(origin_algebraic)
          .and_return(false)
      end

      it 'returns true' do
        result = chess.valid_algebraic?(origin)

        expect(result).to be(false)
      end
    end
  end

  describe '#make_move' do
    context 'when an invalid destination is selected for a board origin' do
      let(:board) { instance_spy(Board) }
      let(:origin) { instance_double(Position) }
      let(:destination) { instance_double(Position) }

      before do
        allow(destination).to receive(:valid_destination?)
          .with(origin, board)
          .and_return(false)
      end

      it 'raises error' do
        expect { chess.make_move(origin, destination) }
          .to raise_error(Chess::InvalidDestinationError)
      end

      it 'does not send move to board' do
        chess.make_move(origin, destination) rescue :EXPECTED_ERROR

        expect(board).not_to have_received(:move)
      end
    end

    context 'when a valid destination is selected for a board origin' do
      let(:board) { instance_spy(Board) }
      let(:origin) { instance_double(Position) }
      let(:destination) { instance_double(Position) }

      before do
        allow(destination).to receive(:valid_destination?)
          .with(origin, board)
          .and_return(true)
      end

      it 'sends board move with origin and destination' do
        chess.make_move(origin, destination)

        expect(board).to have_received(:move)
          .with(origin, destination)
      end
    end
  end
end
