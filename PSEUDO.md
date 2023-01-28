Problem: CheckStatus

I started this mixin as a class but while I was tinkering with it, I made it into a module. Now, I feel I regret the decision and feel like this is the wrong abstraction.

```Ruby
# Check for Board status in reference to the Chess game.
module CheckStatus
  def move_will_create_check?(origin, destination, piece_color)
    self.class.future_board(self, origin, destination).check?(piece_color)
  end

  def check?(piece_color)
    king = king(piece_color)
    return false if king.nil?

    all_destinations(king.opponent_color).any?(piece_position(king))
  end

  def king(color)
    all_pieces(color).find(&:checkable?)
  end

  def all_destinations(color, movement = Movement)
    all_pieces(color).map do |piece|
      movement.destinations(piece_position(piece), self)
    end.flatten(1).uniq
  end

  def all_pieces(color = nil)
    squares.filter_map(&:content).select do |content|
      content&.color == color
    end
  end
end
```

This mixin was created as a way to check if a `King` was in check on the Board. Because it needed to find the King piece for the given piece_color, I thought maybe it belonged included in Board.

It did not feel like it belonged directly in Board. Board right now is all about storing and manipulating its squares content. This feels like something different. It's something like a status, hence the name `CheckStatus`.

However, a status feels like a thing. Maybe it should be its own class?

---

It is interesting trying to find where check belongs. Talking about chess, you say that a "king is in check" like its the status of the king itself.

Right now, it feels more like check is a status of the board given the king piece and the state of the board.

```Ruby
  def check?(piece_color)
    king = king(piece_color)
    return false if king.nil?

    all_destinations(king.opponent_color).any?(piece_position(king))
  end
```
The `#check?` method revolves around the `King` object. I did not think it belonged in `King` though because the class right now knows very little. It does not even know it is on a board.

What would the method look like if the method resided in `King`?
```Ruby
  def check?(board)
    board.all_destinations(opponent_color).any?(board.piece_position(self))
  end
```
That does not look too bad, except it requires `Board` to get injected into `King` somewhere.



So, what is check?

Another interpretation: Check is a status of the game given a board with king pieces.

Perhaps `CheckStatus` belongs in `Chess`. This would be handy in that it is necessary for the game knowing the game is over and to stop looping rounds.


Another thing with `CheckStatus` is that the other methods not about check feel like they belong elsewhere. These feel like 'trackers'. Perhaps they should be another class and component to chess. Potential name: `PieceTracker`.

```Ruby
class PieceTracker; end

class CheckStatus; end

class Game
  def initialize(board:, players:, movement:, piece_types:, piece_tracker:, check_status:)
end

class Board
  def initialize(files:, piece_types:)
end

class Players; end

class Piece; end

class King; end

class Movement
  def initialize(board:, origin:)
end

# Relationship: Tracker(PieceTracker) and Trackable(Board or Pieces?)
class PieceTracker
  def initialize(board:)
end

class CheckStatus
  def initialize(board:)
end

```