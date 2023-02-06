# frozen_string_literal: true

require_relative './../../lib/positions'

RSpec.describe Positions do
  subject(:positions) { described_class.new(positions_array:) }

  # describe '#valid_origin?' do
  #   context 'when positions contains position that matches both criteria' do
  #     let(:positions_array) { instance_double(Array) }
  #     let(:matching_position) { instance_double(Position) }
  #     let(:algebraic_notation) { double }
  #     let(:color) { double }

  #     before do
  #       allow(positions).to receive(:find)
  #         .and_return(matching_position)

  #       allow(matching_position).to receive(:algebraic)
  #       allow(matching_position).to receive(:piece_color)
  #         .and_return(color)
  #     end

  #     it 'returns true' do
  #       result = positions.valid_origin?(algebraic_notation, color)

  #       expect(result).to be(true)
  #     end
  #   end

    # xcontext 'when positions does not have a match to algebraic notation' do
    #   let(:positions_array) do
    #     [instance_double(Position), instance_double(Position)]
    #   end

    #   let(:algebraic_notation) { double }
    #   let(:color) { double }

    #   before do
    #     allow(positions_array[1]).to receive(:piece_color)
    #       .and_return(color)

    #     allow(positions).to receive(:positions)
    #       .and_return(positions_array)
    #   end

    #   it 'returns false' do
    #     result = positions.valid_origin?(algebraic_notation, color)

    #     expect(result).to be(false)
    #   end
    # end

    # context 'when positions does not have a match to player_color' do
    #   it 'returns false'
    # end
  # end
end
