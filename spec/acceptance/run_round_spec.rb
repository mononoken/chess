# frozen_string_literal: true

require_relative './../../lib/chess'

RSpec.describe 'Run Round API' do
  let(:game)      { Chess.new(board:, players:, pieces:, movement:) }
  let(:board)     { Board.new(piece_types: Pieces.piece_types) }
  let(:player1)   { Player.new }
  let(:player2)   { Player.new }
  let(:players)   { [player1, player2] }
  let(:pieces)    { Pieces }
  let(:movement)  { Movement }

  xcontext 'when game has started but no rounds run yet' do
    it 'starts with board at start state' do
      expected_board_s = <<~HEREDOC
        +----+----+----+----+----+----+----+----+
        | R  | N  | B  | Q  | K  | B  | N  | R  |
        +----+----+----+----+----+----+----+----+
        | P  | P  | P  | P  | P  | P  | P  | P  |
        +----+----+----+----+----+----+----+----+
        |    |    |    |    |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        |    |    |    |    |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        |    |    |    |    |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        |    |    |    |    |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        | P  | P  | P  | P  | P  | P  | P  | P  |
        +----+----+----+----+----+----+----+----+
        | R  | N  | B  | Q  | K  | B  | N  | R  |
        +----+----+----+----+----+----+----+----+
      HEREDOC

      expect(board.to_s).to eq(expected_board_s)
    end
  end

  xcontext 'when the first round is run with only valid moves' do
    let(:origin)      { 'd2' }
    let(:destination) { 'd4' }

    before do
      allow(game).to receive(:gets)
        .and_return(origin, destination)
    end

    it 'has current_player as white' do
      expected_player_color = :white

      current_player_color = game.current_player.color

      expect(current_player_color).to eq(expected_player_color)
    end

    it 'changes board to state with one valid move made' do
      game.run_round

      expected_board_s = <<~HEREDOC
        +----+----+----+----+----+----+----+----+
        | R  | N  | B  | Q  | K  | B  | N  | R  |
        +----+----+----+----+----+----+----+----+
        | P  | P  | P  | P  | P  | P  | P  | P  |
        +----+----+----+----+----+----+----+----+
        |    |    |    |    |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        |    |    |    |    |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        |    |    |    | P  |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        |    |    |    |    |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        | P  | P  | P  |    | P  | P  | P  | P  |
        +----+----+----+----+----+----+----+----+
        | R  | N  | B  | Q  | K  | B  | N  | R  |
        +----+----+----+----+----+----+----+----+
      HEREDOC

      expect(board.to_s).to eq(expected_board_s)
    end
  end

  xcontext 'when the second round is run with only valid moves' do
    let(:origin1)      { 'd2' }
    let(:destination1) { 'd4' }
    let(:origin2)      { 'd7' }
    let(:destination2) { 'd5' }

    before do
      allow(game).to receive(:gets)
        .and_return(origin1, destination1, origin2, destination2)
    end

    it 'has current_player as black' do
      game.run_round
      game.run_round

      expected_player_color = :black

      current_player_color = game.current_player.color

      expect(current_player_color).to eq(expected_player_color)
    end

    it 'changes board to state with one valid move made' do
      game.run_round
      game.run_round

      expected_board_s = <<~HEREDOC
        +----+----+----+----+----+----+----+----+
        | R  | N  | B  | Q  | K  | B  | N  | R  |
        +----+----+----+----+----+----+----+----+
        | P  | P  | P  | P  | P  | P  | P  | P  |
        +----+----+----+----+----+----+----+----+
        |    |    |    |    |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        |    |    |    |    |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        |    |    |    | P  |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        |    |    |    |    |    |    |    |    |
        +----+----+----+----+----+----+----+----+
        | P  | P  | P  |    | P  | P  | P  | P  |
        +----+----+----+----+----+----+----+----+
        | R  | N  | B  | Q  | K  | B  | N  | R  |
        +----+----+----+----+----+----+----+----+
      HEREDOC

      expect(board.to_s).to eq(expected_board_s)
    end
  end
end
