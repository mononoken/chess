# frozen_string_literal: true

require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#move' do
    context 'when initial square has content' do
      subject(:one_content_board) do
        described_class.new(squares: one_content_squares)
      end
      let(:one_content_squares) do
        {
          initial_sq: 'content',
          destination_sq: nil
        }
      end

      it 'moves content from initial to destination square' do
        expect { one_content_board.move('initial_sq', 'destination_sq') }.to \
          change { one_content_board.squares[:initial_sq] }
          .from('content')
          .to(nil)
          .and change { one_content_board.squares[:destination_sq] }
          .from(nil)
          .to('content')
      end
    end

    context 'when initial square is empty but destination has content' do
      subject(:invalid_move_board) do
        described_class.new(squares: one_content_squares)
      end
      let(:one_content_squares) do
        {
          initial_sq: nil,
          destination_sq: 'content'
        }
      end

      it 'changes nothing' do
        expect { invalid_move_board.move('empty_sq', 'destination_sq') }.not_to \
          change(invalid_move_board, :squares)
      end

      it 'returns an error msg' do
        expect(invalid_move_board.move('empty_sq', 'destination_sq'))
          .to eq('Invalid move')
      end
    end
  end

  describe '#simple_display' do
    context 'when board has some contents' do
      before do
        some_hash = {
          firs_coordinate: 'something',
          seco_coordinate: 'another',
          thir_coordinate: nil
        }

        allow(board).to receive(:squares)
          .and_return(some_hash)
      end

      it 'returns a simple display of contents' do
        display_visual = <<~HEREDOC
          firs_coordinate: something
          seco_coordinate: another
          thir_coordinate: 
        HEREDOC

        expect(board.simple_display).to eq(display_visual)
      end
    end

    context 'when board is empty' do
      before do
        empty_hash = {
          firs_coordinate: nil,
          seco_coordinate: nil,
          last_coordinate: nil
        }

        allow(board).to receive(:squares)
          .and_return(empty_hash)
      end

      it 'returns an empty visual' do
        empty_visual = <<~HEREDOC
          firs_coordinate: 
          seco_coordinate: 
          last_coordinate: 
        HEREDOC

        expect(board.simple_display).to eq(empty_visual)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
