# frozen_string_literal: true

RSpec.describe Bishop do
  describe '#movement' do
    context 'when board is 3x3 and coordinates have bishop at [2, 0]' do
      subject(:bishop) { described_class.new }
      let(:board_3x3) { instance_double(Board) }

      before do
        coordinates_3x3 = 

        allow(board_3x3).to receive(:boundaries)
          .and_return
      end

      it 'returns array of valid movement' do
        valid_moves = [[1, 1], [0, 2]]

        expect(bishop.movement(board_3x3)).to match_array(valid_moves)
      end
    end

    context 'when board is 5x5 and coordinates have bishop at [2, 2]' do
      it 'returns array of valid movement'
    end
  end
end
