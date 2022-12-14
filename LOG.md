20221213
  I was thinking today what are the things that the program should unquestionably do in the eyes of the user. I came up with:
  - The user/Player should be able to select a Piece to move and move that Piece to a new, valid Square.

  In my current iteration, I reached for this idea quickly by making `#play` send `#move` to `@board`. In previous iterations, I was thinking of this differently. I thought that the `Piece` is what is moving so it should have `#move`. I ended up not liking this though because my attempt was tying Piece and Board closely together. I thought they depended on each other too much.

  Now I am wondering if I like rewording the unquestionable as:
  - The user/Player should be able to input Moves that systematically change the state of the Board.

  This wording to me shows that Movement is a class. Move objects represent the player input that is given to board to interpret into a change to squares.

  Do I come up with Movement first, how Player is involved with Movement or how Board interprets Movement? I've already hinted at Movement with writing the initial `#move` method. I realized that `#move` being refactored to need two parameters is not breaking the stubs in chess_spec. I will start with fixing that.


20221212
  Decided to restart the project after getting more comfortable with RSpec and realizing I did not like how I was using it before. I think I was stubbing excessively before. I also think my classes may have had too many responsibilities as it was not clear to me what the classes would be doing when I made them.

  That said here are responsibilities as I now see them:
  Chess: Send moves to board until game over condition is reached.
  Board: Store Square objects in 2D array and send commands to Square objects.
  Square: Store piece.
  Piece: Keep track of its movement behavior.
  Player: Query valid movement from player input.

  The Board class seems to have two responsibilities. Should it not have #move? If not, who should?

  Who is responsible for populating Board?

  I think the initialize for Board is currently wrong as it is.
  ```Ruby
  def initialize(width: 8, height: 8)
    @squares = Array.new(width) { Array.new(height) }
  end
  ```
  The main problem I see immediately is that it does not allow for loading a saved Board or starting a Board with different parameters.

  The solution seems to me to be to inject the arrays into Board#initialize.


20221125
  My Square and Squares objects feel wrong. Right now, Square objects are creating Chess positions from coordinates. This relationship feels wrong. It feels like the decision of a group of coordinates and group of positions should be determined inside a grouping class, not in the individual Square class.

  Do I need a factory in Board or Squares that creates the correct Square objects for use in Chess?

