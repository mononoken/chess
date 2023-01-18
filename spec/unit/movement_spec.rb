# frozen_string_literal: true

require_relative './../../lib/movement'
require_relative './../../lib/board'

RSpec.describe Movement do
  subject(:movement) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:origin) { double }
  let(:piece) { instance_double(Piece) }

  xdescribe '#destinations' do
    context 'when piece is a knight' do
      it 'returns array of valid knight destinations'
    end

    context 'when piece is a rook' do
      it 'returns array of valid rook destinations'
    end

    context 'when piece step_limit is nil' do
      it 'returns array of positions extending to board boundaries'
    end

    context 'when piece step_limit is 1' do
      it 'returns array of positions limited by one step'
    end
  end
end
