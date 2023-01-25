# # frozen_string_literal: true

# # Take an array and interpret it into a new Piece object.
# class PieceFactory
#   # rubocop:disable Metrics/MethodLength
#   def create(array)
#     type =  case array[0]
#             when 'B'
#               Bishop
#             when 'K'
#               King
#             when 'N'
#               Knight
#             when 'P'
#               Pawn
#             when 'Q'
#               Queen
#             when 'R'
#               Rook
#             end

#     type.new(array[1])
#   end
#   # rubocop:enable Metrics/MethodLength
# end
