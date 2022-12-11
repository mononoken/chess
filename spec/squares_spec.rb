# frozen_string_literal: true

require_relative '../lib/squares'
require_relative '../lib/piece'

# rubocop:disable Metrics/BlockLength

RSpec.describe Squares do
  subject(:squares) { described_class.new }

  describe '#position_exists?' do
    let(:positions) { instance_double(Array) }
    let(:position) { instance_double(Symbol) }

    context 'when positions returns true to any? with position' do
      before do
        allow(squares).to receive(:positions)
          .and_return(positions)
        allow(positions).to receive(:any?)
          .with(position)
          .and_return(true)
      end

      it 'returns true' do
        result = squares.position_exists?(position)

        expect(result).to be(true)
      end
    end

    context 'when positions returns false to any? with position' do
      before do
        allow(squares).to receive(:positions)
          .and_return(positions)
        allow(positions).to receive(:any?)
          .with(position)
          .and_return(false)
      end

      it 'returns false' do
        result = squares.position_exists?(position)

        expect(result).to be(false)
      end
    end
  end

  describe '#valid_coords' do
    context 'when squares coordinates include [0, 0] [42, 42], [0, 99]' do
      subject(:squares) { described_class.new(sq0, sq1, sq2) }
      let(:sq0) { instance_double(Square) }
      let(:sq1) { instance_double(Square) }
      let(:sq2) { instance_double(Square) }

      before do
        allow(sq0).to receive(:coordinates)
          .and_return([0, 0])
        allow(sq1).to receive(:coordinates)
          .and_return([42, 42])
        allow(sq2).to receive(:coordinates)
          .and_return([0, 99])
      end
      it 'returns array of unique integers [0, 42, 99]' do
        existing_coord_values = [0, 42, 99]

        expect(squares.valid_coords).to match_array(existing_coord_values)
      end
    end

    context 'when squares coordinates include [11, 1] [23, 7]' do
      subject(:squares) { described_class.new(sq0, sq1) }
      let(:sq0) { instance_double(Square) }
      let(:sq1) { instance_double(Square) }

      before do
        allow(sq0).to receive(:coordinates)
          .and_return([11, 1])
        allow(sq1).to receive(:coordinates)
          .and_return([23, 7])
      end
      it 'returns array of unique integers [1, 7, 11, 23]' do
        existing_coord_values = [1, 7, 11, 23]

        expect(squares.valid_coords).to match_array(existing_coord_values)
      end
    end
  end

  describe '#piece_color' do
    context 'when three pieces match the selected color' do
      subject(:squares) do
        described_class.new(sq1_black, sq2_black, sq3_white, sq4_black,
                            sq5_white)
      end
      let(:sq1_black) { instance_double(Square) }
      let(:sq2_black) { instance_double(Square) }
      let(:sq3_white) { instance_double(Square) }
      let(:sq4_black) { instance_double(Square) }
      let(:sq5_white) { instance_double(Square) }

      before do
        allow(sq1_black).to receive(:piece_color)
          .and_return(:black)
        allow(sq2_black).to receive(:piece_color)
          .and_return(:black)
        allow(sq3_white).to receive(:piece_color)
          .and_return(:white)
        allow(sq4_black).to receive(:piece_color)
          .and_return(:black)
        allow(sq5_white).to receive(:piece_color)
          .and_return(:white)
      end

      it 'returns array of Square objects containing those pieces' do
        black_sqs = [sq1_black, sq2_black, sq4_black]

        expect(squares.piece_color(:black)).to match_array(black_sqs)
      end
    end
  end

  describe '#moves' do
    context 'when selected position has a piece' do
      let(:squares) { described_class.new(occupied_square) }
      let(:occupied_square) { instance_double(Square) }
      let(:selected_position) { :some_position }
      let(:valid_moves) { %i[here there over_there] }

      before do
        allow(squares).to receive(:find_square)
          .with(selected_position)
          .and_return(occupied_square)

        allow(occupied_square).to receive(:moves)
          .and_return(valid_moves)
      end

      it 'returns array of valid moves for piece in selected square' do
        expect(squares.moves(selected_position)).to eq(valid_moves)
      end
    end

    context 'when a different selected position has a piece' do
      let(:squares) { described_class.new(occupied_square) }
      let(:occupied_square) { instance_double(Square) }
      let(:different_position) { :some_position }
      let(:valid_moves) { %i[different_move another_move] }

      before do
        allow(squares).to receive(:find_square)
          .with(different_position)
          .and_return(occupied_square)

        allow(occupied_square).to receive(:moves)
          .and_return(valid_moves)
      end

      it 'returns array of valid moves for piece in selected square' do
        expect(squares.moves(different_position)).to eq(valid_moves)
      end
    end
  end

  describe '#find_square' do
    context 'when a square matches the selected position' do
      subject(:squares) { described_class.new(other_square, selected_square) }
      let(:other_square) { instance_double(Square) }
      let(:selected_square) { instance_double(Square) }
      let(:other_position) { :houston }
      let(:selected_position) { :seattle }

      before do
        allow(other_square).to receive(:position)
          .and_return(other_position)
        allow(selected_square).to receive(:position)
          .and_return(selected_position)
      end

      it 'returns square object' do
        found = squares.find_square(selected_position)
        expect(found).to eq(selected_square)
      end
    end

    context 'when no square has the selected position' do
      subject(:squares) { described_class.new(other_square, another_square) }
      let(:other_square) { instance_double(Square) }
      let(:another_square) { instance_double(Square) }
      let(:other_position) { :houston }
      let(:another_position) { :miami }
      let(:selected_position) { :seattle }

      before do
        allow(other_square).to receive(:position)
          .and_return(other_position)
        allow(another_square).to receive(:position)
          .and_return(another_position)
      end

      it 'returns nil' do
        not_found = squares.find_square(selected_position)
        expect(not_found).to be_nil
      end
    end
  end

end

# rubocop:enable Metrics/BlockLength
