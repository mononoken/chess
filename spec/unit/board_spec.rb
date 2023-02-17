# frozen_string_literal: true

require_relative './../../lib/board'
require_relative './../../lib/position'
require_relative './../../lib/pieces/rook'

RSpec.describe Board do
  subject(:board) { described_class.new(files:) }
  let(:files) { Array.new(2) { Array.new(2) { Square.new } } }

  # Promotion functionality has been added that is not tested.
  # describe '#move' do
  #   before :each do
  #     allow(board).to receive(:record_move)
  #   end

  #   context 'when origin square is populated' do
  #     let(:rook) { instance_double(Rook) }
  #     let(:origin) { instance_double(Position) }
  #     let(:destination) { instance_double(Position) }

  #     before do
  #       allow(origin).to receive(:file_index)
  #         .and_return(0)
  #       allow(origin).to receive(:rank_index)
  #         .and_return(0)
  #       allow(destination).to receive(:file_index)
  #         .and_return(0)
  #       allow(destination).to receive(:rank_index)
  #         .and_return(1)

  #       allow(rook).to receive(:promotable?)
  #         .and_return(false)

  #       board.populate(rook, origin)
  #     end

  #     it 'moves origin population to destination square' do
  #       board.move(origin, destination)

  #       destination_square = board.files[0][1]

  #       expect(destination_square.content).to eq(rook)
  #     end
  #   end

  #   context 'when origin square is empty' do
  #     let(:origin) { instance_double(Position) }
  #     let(:destination) { instance_double(Position) }

  #     before do
  #       allow(origin).to receive(:file_index)
  #         .and_return(0)
  #       allow(origin).to receive(:rank_index)
  #         .and_return(1)
  #       allow(destination).to receive(:file_index)
  #         .and_return(1)
  #       allow(destination).to receive(:rank_index)
  #         .and_return(1)
  #     end

  #     it 'raises error' do
  #       expect { board.move(origin, destination) }.to \
  #         raise_error(Board::EmptyOriginError)
  #     end

  #     it 'does not change the desination square' do
  #       destination_square = board.files[1][1]

  #       expect { board.move(origin, destination) rescue :EXPECTED_ERROR }
  #         .not_to change { destination_square.content }
  #     end
  #   end
  # end

  describe '#populate' do
    # before :each do
    #   allow(origin).to receive(:file_index)
    #     .and_return(x)
    #   allow(origin).to receive(:rank_index)
    #     .and_return(y)
    # end

    context 'when rook is placed at 0, 0' do
      let(:rook) { instance_double(Rook) }
      let(:position) { instance_double(Position) }
      let(:x) { 0 }
      let(:y) { 0 }

      before do
        allow(position).to receive(:file_index)
          .and_return(x)
        allow(position).to receive(:rank_index)
          .and_return(y)
      end

      it 'changes square content at [0][0] to rook' do
        square = board.files[x][y]

        board.populate(rook, position)

        expect(square.content).to eq(rook)
      end
    end

    context 'when rook is placed at 1, 0' do
      let(:rook) { instance_double(Rook) }
      let(:position) { instance_double(Position) }
      let(:x) { 1 }
      let(:y) { 0 }

      before do
        allow(position).to receive(:file_index)
          .and_return(x)
        allow(position).to receive(:rank_index)
          .and_return(y)
      end

      it 'changes square content at [1][0] to rook' do
        square = board.files[x][y]

        board.populate(rook, position)

        expect(square.content).to eq(rook)
      end
    end
  end

  describe '#piece' do
    let(:files) { Array.new(2) { Array.new(2) { instance_double(Square) } } }
    let(:content) { double }
    let(:position) { instance_double(Position) }
    let(:x) { 1 }
    let(:y) { 0 }

    before do
      allow(position).to receive(:file_index)
        .and_return(x)
      allow(position).to receive(:rank_index)
        .and_return(y)
      allow(files[x][y]).to receive(:content)
        .and_return(content)
    end

    it 'returns outgoing content query from square of position' do
      expect(board.piece(position)).to be(content)
    end
  end

  # FIX_ME
  # describe '#occupied_positions' do
  #   let(:files) { Array.new(2) { Array.new(2) { instance_double(Square) } } }

  #   context 'when three squares have pieces of selected color' do
  #     let(:matching_squares) { [files[0][0], files[0][1], files[1][0]] }
  #     let(:mismatch_squares) { [files[1][1]] }

  #     let(:color) { :black }

  #     before do
  #       matching_squares.each do |square|
  #         allow(square).to receive(:piece_color?)
  #           .with(color)
  #           .and_return(true)
  #       end

  #       mismatch_squares.each do |square|
  #         allow(square).to receive(:piece_color?)
  #           .with(color)
  #           .and_return(false)
  #       end
  #     end

  #     it 'returns array of the three occupied squares positions' do
  #       matching_positions = [[0, 0], [0, 1], [1, 0]]

  #       expect(board.occupied_positions(color)).to match_array(matching_positions)
  #     end
  #   end

  #   context 'when no squares have pieces of selected color' do
  #     let(:matching_squares) { [] }
  #     let(:mismatch_squares) do
  #       [files[0][0], files[0][1], files[1][0], files[1][1]]
  #     end

  #     let(:color) { :purple }

  #     before do
  #       mismatch_squares.each do |square|
  #         allow(square).to receive(:piece_color?)
  #           .with(color)
  #           .and_return(false)
  #       end
  #     end

  #     it 'return nil' do
  #       matching_positions = []

  #       expect(board.occupied_positions(color)).to match_array(matching_positions)
  #     end
  #   end
  # end
end
