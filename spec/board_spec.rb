# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/squares'

# rubocop:disable Metrics/BlockLength

RSpec.describe Board do
  describe '#moves' do
    context 'when selected square has a piece' do
      subject(:board) { described_class.new(squares:) }
      let(:squares) { instance_double(Squares) }
      let(:selected_position) { :some_position }
      let(:valid_moves) { %i[a_move another_move] }

      before do
        allow(squares).to receive(:moves)
          .with(selected_position)
          .and_return(valid_moves)
      end

      it 'returns array of valid moves for piece in selected square' do
        expect(board.moves(selected_position)).to eq(valid_moves)
      end
    end

    context 'when selected square has a different piece' do
      subject(:board) { described_class.new(squares:) }
      let(:squares) { instance_double(Squares) }
      let(:selected_position) { :another_position }
      let(:valid_moves) { %i[move1 move2 move3 move4 move5] }

      before do
        allow(squares).to receive(:moves)
          .with(selected_position)
          .and_return(valid_moves)
      end

      it 'returns array of valid moves for piece in selected square' do
        expect(board.moves(selected_position)).to eq(valid_moves)
      end
    end

    context 'when selected square has no piece' do
      it 'returns an error'
    end
  end

  describe '#simple_display' do
    context 'when squares contains one entry with content' do
      subject(:solo_board) { described_class.new(squares: solo_squares) }
      let(:solo_squares) { instance_double(Squares) }

      before do
        squares_str = <<~HEREDOC
          xy: something
        HEREDOC

        allow(solo_squares).to receive(:simple_display)
          .and_return(squares_str)
      end

      it 'returns string of single square position and content' do
        solo_display = <<~HEREDOC
          Board simple display:
          xy: something
        HEREDOC

        expect(solo_board.simple_display).to eq(solo_display)
      end
    end

    context 'when squares contains four entries with some content' do
      subject(:multi_board) { described_class.new(squares: multi_squares) }
      let(:multi_squares) { instance_double(Squares) }

      before do
        squares_str = <<~HEREDOC
          a1: something
          a2: something_else
          a3:
          a4: important_thing
        HEREDOC

        allow(multi_squares).to receive(:simple_display)
          .and_return(squares_str)
      end

      it 'returns string of all square positions and contents' do
        multi_display = <<~HEREDOC
          Board simple display:
          a1: something
          a2: something_else
          a3:
          a4: important_thing
        HEREDOC

        expect(multi_board.simple_display).to eq(multi_display)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
