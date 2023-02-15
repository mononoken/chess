# frozen_string_literal: true

require_relative './piece'
require_relative './pieces'

class Pawn < Piece
  def self.start_positions
    [
      StartPosition.new(position: [0, 1], color: :white),
      StartPosition.new(position: [1, 1], color: :white),
      StartPosition.new(position: [2, 1], color: :white),
      StartPosition.new(position: [3, 1], color: :white),
      StartPosition.new(position: [4, 1], color: :white),
      StartPosition.new(position: [5, 1], color: :white),
      StartPosition.new(position: [6, 1], color: :white),
      StartPosition.new(position: [7, 1], color: :white),
      StartPosition.new(position: [0, 6], color: :black),
      StartPosition.new(position: [1, 6], color: :black),
      StartPosition.new(position: [2, 6], color: :black),
      StartPosition.new(position: [3, 6], color: :black),
      StartPosition.new(position: [4, 6], color: :black),
      StartPosition.new(position: [5, 6], color: :black),
      StartPosition.new(position: [6, 6], color: :black),
      StartPosition.new(position: [7, 6], color: :black)
    ]
  end

  def self.algebraic
    :P
  end

  def promotion_choice(pieces_class = Pieces)
    loop do
      puts 'Pick promotion piece: Q(ueen) (K)N(ight) B(ishop) R(ook)'
      choice = gets.chomp.upcase.to_sym

      return pieces_class.piece_class(choice) if pieces_class.pawn_promotion_option?(choice)
    end
  end

  def promotion_position?(destination)
    promotion_positions.any?(destination.algebraic)
  end

  def promotion_positions
    case color
    when :white
      %i[a8 b8 c8 d8 e8 f8 g8 h8]
    when :black
      %i[a1 b1 c1 d1 e1 f1 g1 h1]
    end
  end

  def promotable?
    true
  end

  def take_directions
    case color
    when :white
      [[-1, 1], [1, 1]]
    when :black
      [[-1, -1], [1, -1]]
    end
  end

  def step_directions
    case color
    when :white
      [[0, 1]]
    when :black
      [[0, -1]]
    end
  end

  def special_first_step
    case color
    when :white
      [[0, 2]]
    when :black
      [[0, -2]]
    end
  end

  def step_take?
    false
  end

  def step_limit
    1
  end

  def skin
    "\u265F"
  end
end
