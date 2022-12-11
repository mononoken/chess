# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/square'

# rubocop:disable Metrics/BlockLength

RSpec.describe Board do
  subject(:board) { described_class.new(*squares) }
  describe '#simple_display' do
    context 'when squares contains one entry with content' do
      let(:one_square) { instance_double(Square) }
      let(:squares) { [one_square] }

      before do
        one_display = 'xy: something'

        allow(one_square).to receive(:simple_display)
          .and_return(one_display)
      end

      it 'returns string of single square position and content' do
        solo_display = <<~HEREDOC
          xy: something
        HEREDOC

        expect(board.simple_display).to eq(solo_display)
      end
    end

    context 'when squares contains four entries with some content' do
      let(:one_square) { instance_double(Square) }
      let(:two_square) { instance_double(Square) }
      let(:thr_square) { instance_double(Square) }
      let(:fou_square) { instance_double(Square) }
      let(:squares) { [one_square, two_square, thr_square, fou_square] }

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

        expect(board.simple_display).to eq(multi_display)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
