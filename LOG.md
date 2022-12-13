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

