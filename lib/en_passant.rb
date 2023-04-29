# frozen_string_literal: true

require_relative './position'

module EnPassant
  # Behavior for pieces that can be captured in En Passant.
  module PassantVictim
    attr_accessor :passantable # This might need to be assigned false initially.

    def passantable?
      passantable
    end
  end

  module NonPassantVictim
    def passsantable
      false
    end

    def passantable?
      false
    end
  end

  # Behavior for pieces that can make the En Passant movement.
  module Passanter
    def passant_rights?
      true
    end
  end

  module NonPassanter
    def passant_rights?
      false
    end
  end

  # Behavior that adds recording passant victims when moved.
  module PassantRecorder
    def record_passantable(piece)
      return unless piece.respond_to?(:passantable)

      return if piece.first_move_taken?

      piece.passantable = true
    end
  end

  # Movement behavior for movements with origin piece as a passanter.
  module PassantMovement
    def en_passant?
      destination == passant_destination
    end

    # Returns array of valid passant destinations.
    # Note: This returns an array to match other destination array formats.
    def valid_passant_destinations(piece, board)
      [
        (passant_destination(piece, board) if piece_on_passanter_origin?(piece, board))
      ]
    end

    def passant_victim?
      passant_victim_position.piece.passantable?
    end

    def capture_passant_victim
      passant_victim_position.empty
    end

    private

    def piece_on_passanter_origin?(piece, board)
      valid_passanter_origins(board).any? { |origin| origin.piece == piece }
    end

    # Finds passant destination relative to victim position.
    def passant_destination(piece = self.piece, board = self.board)
      case piece.color
      when :white
        board.positions.relative_position(passant_victim_position(board), [0, 1])
      when :black
        board.positions.relative_position(passant_victim_position(board), [0, -1])
      end
    end

    def valid_passanter_origins(board)
      passanter_origins(passant_victim_position(board), board).filter do |origin|
        origin.piece.passant_rights?
      end
    end

    def passanter_origins(victim_position, board)
      [[-1, 0], [1, 0]].map do |step|
        board.positions.relative_position(victim_position, step)
      end
    end

    def passant_victim_position(board = self.board)
      board.positions.find { |position| position.piece.passantable? } || NilPosition.new
    end
  end
end
