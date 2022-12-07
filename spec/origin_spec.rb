# frozen_string_literal: true

require_relative './../lib/origin'
require_relative './../lib/board'
require_relative './../lib/player'

# rubocop:disable Metrics/BlockLength

RSpec.describe Origin do
  subject(:origin) { described_class.new(position:, player:, board:) }
  let(:position) { :some_position }
  let(:player) { instance_double(Player) }
  let(:board) { instance_double(Board) }

  describe '#valid?' do
    let(:checks) { instance_double(Array) }

    context 'when checks returns true to all?(true)' do
      before do
        allow(origin).to receive(:checks)
          .and_return(checks)
        allow(checks).to receive(:all?)
          .with(true)
          .and_return(true)
      end

      it 'returns true' do
        expect(origin.valid?).to be(true)
      end
    end

    context 'when checks returns false to all?(true)' do
      before do
        allow(origin).to receive(:checks)
          .and_return(checks)
        allow(checks).to receive(:all?)
          .with(true)
          .and_return(false)
      end

      it 'returns false' do
        expect(origin.valid?).to be(false)
      end
    end
  end

  # DELETE THESE TESTS IF FAIL (PRIVATE METHODS).

  # describe '#player_owns?' do
  #   let(:piece) { double }

  #   context 'when player color and piece color match' do
  #     let(:same_color) { double }
  #     before do
  #       allow(origin).to receive(:piece)
  #         .and_return(piece)
  #       allow(piece).to receive(:color)
  #         .and_return(same_color)

  #       allow(player).to receive(:color)
  #         .and_return(same_color)
  #     end

  #     it 'returns true' do
  #       expect(origin.player_owns?).to be(true)
  #     end
  #   end

  #   context 'when player color and piece color do not match' do
  #     let(:one_color) { double }
  #     let(:diff_color) { double }
  #     before do
  #       allow(origin).to receive(:piece)
  #         .and_return(piece)
  #       allow(piece).to receive(:color)
  #         .and_return(one_color)

  #       allow(player).to receive(:color)
  #         .and_return(diff_color)
  #     end

  #     it 'returns false' do
  #       expect(origin.player_owns?).to be(false)
  #     end
  #   end

  #   context 'when piece returns nil' do
  #     let(:one_color) { double }
  #     before do
  #       allow(origin).to receive(:piece)
  #         .and_return(nil)

  #       allow(player).to receive(:color)
  #         .and_return(one_color)
  #     end

  #     it 'returns false' do
  #       expect(origin.player_owns?).to be(false)
  #     end
  #   end
  # end

  # describe '#piece?' do
  #   let(:square) { double(Square) }

  #   context 'when square returns false to empty?' do
  #     before do
  #       allow(origin).to receive(:square)
  #         .and_return(square)
  #       allow(square).to receive(:empty?)
  #         .and_return(false)
  #     end

  #     it 'returns true' do
  #       result = origin.piece?

  #       expect(result).to be(true)
  #     end
  #   end

  #   context 'when square returns true to empty?' do
  #     before do
  #       allow(origin).to receive(:square)
  #         .and_return(square)
  #       allow(square).to receive(:empty?)
  #         .and_return(true)
  #     end

  #     it 'returns false' do
  #       result = origin.piece?

  #       expect(result).to be(false)
  #     end
  #   end
  # end

  # describe '#on_board?' do
  #   context 'when board returns true to position_exists? with position' do
  #     before do
  #       allow(board).to receive(:position_exists?)
  #         .with(position)
  #         .and_return(true)
  #     end

  #     it 'returns true' do
  #       expect(origin.on_board?).to be(true)
  #     end
  #   end

  #   context 'when board returns false to position_exists? with position' do
  #     before do
  #       allow(board).to receive(:position_exists?)
  #         .with(position)
  #         .and_return(false)
  #     end

  #     it 'returns false' do
  #       expect(origin.on_board?).to be(false)
  #     end
  #   end
  # end
end

# rubocop:enable Metrics/BlockLength
