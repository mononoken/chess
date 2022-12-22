20221221
  I have three types of pieces currently. King, rook, and bishop. I will later have three more types: Queen, Knight, Pawn. The pawn is the most interesting of the future pieces.

  I am trying to decide how to continue with these pieces. They already share behavior and methods and differ as well. I am pondering the differences between approaching this as a system using inheritance or composition.

  A rook is-a piece. A pawn is-a piece. Sandi Metz suggests is-a relationships work best with inheritance. 

  I can see inheritance making a lot of sense. If I just had Piece objects which had different moves like a piece that has-a KnightMoves, that is not what we really have here. A `Knight` is a `Piece`, but it is also a `Knight`. Moves are not the only way pieces differ. They also differ in appearance and some have special rules, especially the pawn.

  A rook has-a rook moveset. A pawn has-a pawn moveset. This has-a relationship suggests composition.

  Should I be utilizing both inheritance **AND** composition? What would this look like?

  So far, the differences between the three existing pieces exist below their `#movement`. There is a slight difference in `#movement` methods, but this difference could easily be moved below.

  There is a *Move* behavior here that suggests two roles:
  1. *Movable* which are the pieces. They have `#movement` and `#valid_destination?`.
  2. *Movers* which is the game `Chess`. It sends `#move` to `Board` given `#valid_destination?` is true for the *Movable*.

  Both of these roles could be moved to a module called `Move`(??). In the module there would be two classes, `Movable` and `Mover`.

  A piece *has-a* `Moveset`. Having a `Moveset` allows an object to play the `Movable` role.

  `RookMoveset` includes `Movable`. It implements the `Movable` methods and overrides those that are necessary to make it unique. Movesets differ in their `#paths`.

  ---

  All those thoughts got me lost. I am thinking specifically about `Pawns` now because they provide perhaps the biggest design issues.

  Pawns can become another type of Piece. Thinking about this in code, how would I get this to happen? If I had a `Pawn` class, would the object be replaced by a different piece at promotion? That could work, and I don't see too much issue with this. However, it makes the word *promotion* feel wrong. The piece is the same, but it has been promoted/transformed/evolved into a new form. 

  Changing the class of an object in Ruby sounds like it is not possible from a quick StackOverflow search (https://stackoverflow.com/questions/7528552/is-it-possible-to-change-the-class-of-a-ruby-object). If it is not possible, it is also probably a bad idea.

  However, what if pawn was simply a piece entirely composed of pawn components? In other words it was a `Piece` with `@moves = pawn_moves` and `@appearance = pawn_appearance`. Then, to transform the piece, these instance variables simply need to be changed. The object is the same, but it is now composed entirely differently.

  ---

  `#path` differs between `King` vs `Rook` and `Bishop`. `Rook` and `Bishop` want `#path` to iterate until it hits a border. `King` only wants path to take one step. I could set the boundaries around the origin. Perhaps that is where the actual difference lies. A King has a boundary around itself, a one square 'radius'. Bishop and Rook have the board as their boundary.

  Thinking ahead, what is the boundary of a knight? I could set a radius for that as well, but really as a human I think simply that knight can only make one of several 'steps'.

  Also, a king still has the board as a boundary as well. The step limit is an additional limitation it has. A limitation that simply does not apply to bishop and rook.

  ---

  What is the difference between putting behavior in a module vs a class?

  In my head now, the difference is that a class instantiates objects, while a module just shares methods/behavior. Instantiated objects have instance variables.

  For this problem with chess project, this is the solution I am thinking to try:

  `Piece` class composed with a moveset. Each piece type has a moveset class such as `RookMoveset`. Each moveset shares a role using a shared module, `Movable`.

  There will be a test that each moveset must pass to play the `Movable` role.

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

