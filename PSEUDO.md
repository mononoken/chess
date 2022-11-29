First task:
Create `Board` that can generate pieces based on array given to it.`

Second task:
Where does the calculation of valid moves occur?
- Pieces can know their possible movement based on coordinates
  - How does a piece know the limits of the board? Some pieces can move infinitely in any direction, and their choices are limited by board dimensions.
- Board/Squares knows limitation of all possible coordinates based on all positions and coordinates contained in Squares
  - Should this knowledge be injected into Pieces upon creation?
  - Should pieces query Squares each time they have to move?
**  - It feels like Squares already knows the limitations and so these limitations should be injected into Pieces upon creation rather than having to query every time.**
- Coordinates and Positions are related. They can be converted between each other.
  - Where should conversions occur? This knowledge feels like it should be contained in one central spot that other objects can access.
**    - It feels like perhaps Square should know the conversion of coordinates and position.**
- Limitations of movement include:
  - Board dimension limitations
  - Piece movement behavior
**  - Pieces that are in the way of movement
    - This requires that limitations be constantly queried by `Piece` since the state of `Board`'s `Squares` is constantly changing**

Valid moves:
1. `Board` wants to display all the possible `Square` objects that are valid moves for the selected `Square`'s `Piece`.
2. `Board` queries `Squares` given the selected position.
3. `Squares` uses `#find` to check if it contains a Square that matches #position.
4. If there is a match, `Squares` queries `Square` which queries `Piece` for valid moves.
5. `Piece` has method `#moves` that calculations for all valid moves.
6. `#moves` calculates valid moves based off of `#movement` along with `#limitations`(???)
  - What is `#limitations`?
    - We could pass `board_state` through `#moves` to `Piece`. This way, Piece knows the state of the board without having to access the board itself.
    - `Piece` would have to decrypt `board_state` into data for calculating `#valid_moves`
  - What are the different kinds of data that `board_state` should supply?
    - all existing squares (this is constant)
    - empty squares
    - squares filled by same color
    - squares filled by opponent color


What are the domain objects of Chess?
- Board
- Players (2 types)
- Pieces (6 types)

I am drawn to starting with Board. There are intriguing things about it.

Board has:
- Data (its contents)
- Positions (coordinates)
- Limitations

If Board is an Array then each ite would have both contents and position.

Should each index thus contain an Array of two items, one being the contents and one the position?

Words:
- Board
- Position
- Piece
- Data
- Content
