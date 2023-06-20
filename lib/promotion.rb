require_relative "./pieces/bishop"
require_relative "./pieces/knight"
require_relative "./pieces/queen"
require_relative "./pieces/rook"

module Promotion
  module Promoter
    def promotion_action
      -> {
        populate(content.promotion_choice.new(content.color),
          movement.destination)
      }
    end

    def promotion?
      piece.promotable? && piece.promotion_position?(destination)
    end
  end

  module Promotable
    PROMOTION_OPTIONS = %i[q n b r]
    PROMOTION_CLASSES = [Bishop, Knight, Queen, Rook]

    def promotion_choice
      loop do
        puts "Pick promotion piece: Q(ueen) (K)N(ight) B(ishop) R(ook)"
        choice = gets.chomp.downcase.to_sym

        return piece_class(choice) if PROMOTION_OPTIONS.any?(choice)
      end
    end

    def promotable?
      true
    end

    def promotion_position?(destination)
      promotion_positions.any?(destination.algebraic)
    end

    private

    def piece_class(algebraic)
      PROMOTION_CLASSES.find { |piece_class| piece_class.algebraic == algebraic }
    end

    def promotion_positions
      case color
      when :white
        %i[a8 b8 c8 d8 e8 f8 g8 h8]
      when :black
        %i[a1 b1 c1 d1 e1 f1 g1 h1]
      end
    end
  end
end
