# frozen_string_literal: true

require_relative '../lib/squares'
require_relative '../lib/piece'

# rubocop:disable Metrics/BlockLength

RSpec.describe Squares do
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

  describe '#simple_display' do
    context 'when squares contains one entry with content' do
      subject(:solo_squares) { described_class.new(one_square) }
      let(:one_square) { instance_double(Square) }

      before do
        one_display = 'xy: something'

        allow(one_square).to receive(:simple_display)
          .and_return(one_display)
      end

      it 'returns string of single square position and content' do
        solo_display = <<~HEREDOC
          xy: something
        HEREDOC

        expect(solo_squares.simple_display).to eq(solo_display)
      end
    end

    context 'when squares contains four entries with some content' do
      subject(:multi_squares) do
        described_class.new(one_square, two_square, thr_square, fou_square)
      end
      let(:one_square) { instance_double(Square) }
      let(:two_square) { instance_double(Square) }
      let(:thr_square) { instance_double(Square) }
      let(:fou_square) { instance_double(Square) }

      before do
        one_display = 'a1: something'
        allow(one_square).to receive(:simple_display)
          .and_return(one_display)

        two_display = 'a2: something_else'
        allow(two_square).to receive(:simple_display)
          .and_return(two_display)

        thr_display = 'a3:'
        allow(thr_square).to receive(:simple_display)
          .and_return(thr_display)

        fou_display = 'a4: important_thing'
        allow(fou_square).to receive(:simple_display)
          .and_return(fou_display)
      end

      it 'returns string of all square positions and contents' do
        multi_display = <<~HEREDOC
          a1: something
          a2: something_else
          a3:
          a4: important_thing
        HEREDOC

        expect(multi_squares.simple_display).to eq(multi_display)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
