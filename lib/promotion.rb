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
    # FIX_ME this file requires pieces.rb but pieces.rb also requires it.
    def promotion_choice(pieces_class = Pieces)
      loop do
        puts "Pick promotion piece: Q(ueen) (K)N(ight) B(ishop) R(ook)"
        choice = gets.chomp.upcase.to_sym

        return pieces_class.piece_class(choice) if pieces_class.pawn_promotion_option?(choice)
      end
    end

    def promotable?
      true
    end

    def promotion_position?(destination)
      promotion_positions.any?(destination.algebraic)
    end

    private

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
