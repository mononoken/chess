# frozen_string_literal: true

require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

RSpec.describe Board do
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
