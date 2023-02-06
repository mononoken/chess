# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe Chess do
  subject(:chess) { described_class.new(board:, movement:) }
  let(:movement) { class_double(Movement) }

  # describe '#player_origin' do
  #   let(:board) { instance_double(Board) }
  #   context 'when positions returns true to valid_origin? with gets' do
  #     let(:positions) { instance_double(Positions) }
  #     let(:valid_gets) { double }

  #     before do
  #       allow(board).to receive(:valid_origin?)
  #         .with(origin, player_color)
  #         .and_return(true)
  #       allow(chess).to receive(:gets)
  #         .and_return(valid_gets)
  #     end

  #     it 'returns gets result' do
  #       expect(chess.player_origin).to eq(valid_gets)
  #     end
  #   end

  #   xcontext 'when positions returns false then true to valid_origin? with gets' do
  #     let(:positions) { instance_double(Positions) }
  #     let(:valid_gets) { double }
  #     let(:invalid_gets) { double }

  #     before do
  #       allow(positions).to receive(:valid_origin?)
  #         .and_return(false, true)
  #       allow(chess).to receive(:gets)
  #         .and_return(double, valid_gets)
  #     end

  #     it 'raises invalid_origin error once'
  #     it 'sends gets twice'
  #     it 'returns gets second result'
  #   end
  # end

  describe '#make_move' do
    context 'when an invalid destination is selected for a board origin' do
      let(:board) { instance_spy(Board) }
      let(:origin) { [4, 2] }
      let(:destination) { [5, 5] }

      before do
        allow(movement).to receive(:valid_destination?)
          .with(destination, origin, board)
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
      let(:origin) { [0, 0] }
      let(:destination) { [7, 0] }

      before do
        allow(movement).to receive(:valid_destination?)
          .with(destination, origin, board)
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
