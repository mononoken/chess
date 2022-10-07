First task:
Create `Board` that can generate pieces based on array given to it.`

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
