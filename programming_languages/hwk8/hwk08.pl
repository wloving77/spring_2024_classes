:- use_module(library(clpfd)).

setup_board(Board) :-
    % Define the board dimensions and set up the board matrix.
    length(Board,7),
    maplist(same_length(Board), Board),
    
    % Initialize each cell in the board.
    append(Board, Cells),
    maplist(init_rook, Cells),

    % Apply constraints to each row and column for unique colors and heights.
    maplist(all_unique_colors_heights, Board),
    transpose(Board, Columns),
    maplist(all_unique_colors_heights, Columns),

    % Flatten the board into a list of cells and convert each rook to a unique integer.
    maplist(rook_to_integer, Cells, EncodedCells),
    
    % Ensure each encoded integer is unique across the board.
    all_distinct(EncodedCells),

    % Labeling for solving.
    label_rooks(EncodedCells).

init_rook(rook(Color, Height)) :-
    Color in 1..8,
    Height in 1..8.

label_rooks(Rooks) :-
    labeling([ffc], Rooks).

all_unique_colors_heights(Row) :-
    % Extract colors and heights.
    row_colors_heights(Row, Colors, Heights),
    all_distinct(Colors),
    all_distinct(Heights).

row_colors_heights([], [], []).
row_colors_heights([rook(Color, Height) | Rest], [Color | Colors], [Height | Heights]) :-
    row_colors_heights(Rest, Colors, Heights).

rook_to_integer(rook(Color, Height), Integer) :-
    Integer #= 8 * (Color - 1) + Height.
